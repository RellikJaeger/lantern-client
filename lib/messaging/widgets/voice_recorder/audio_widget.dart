import 'dart:async';
import 'dart:typed_data';

import 'package:lantern/messaging/messaging_model.dart';
import 'package:lantern/messaging/widgets/voice_recorder/slider_audio/rectangle_slider_thumb_shape.dart';
import 'package:lantern/model/protos_flutteronly/messaging.pb.dart';
import 'package:lantern/package_store.dart';
import 'package:lantern/utils/audio.dart';
import 'package:lantern/utils/waveform/wave_progress_bar.dart';
import 'package:lantern/utils/waveform_extension.dart';
import 'package:loader_overlay/loader_overlay.dart';

enum PlayerState { stopped, playing, paused }

class AudioValue {
  Duration? duration;
  Duration? realDuration;
  Duration? position;
  int? pendingPercentage;
  var reducedAudioWave = <double>[];
  PlayerState playerState = PlayerState.stopped;

  bool get isPlaying => playerState == PlayerState.playing;

  bool get isPaused => playerState == PlayerState.paused;
}

// (crdzbird): For some reason we have 2 different final times.
//2887: is from the thumbnail or decrypted audio.
//2388: is the final time from the audio.
// 2594: is the final time from the audio using audioplayers.
// When we start the player, we always receive a progress percentage below 100%.
// the missing difference is obtained from the thumbnail `2887` and the final time `2594`.
// once we have that time difference we can override the thumbnail time with the new final time.

int percentageOf(int value, int maxValue, int limit) =>
    (100 - (((value) / maxValue) * limit)).toInt();

class AudioController extends ValueNotifier<AudioValue> {
  final BuildContext context;
  final StoredAttachment attachment;
  final double barsLimit;
  late MessagingModel model;
  late Audio audio;

  AudioController(
      {required this.context,
      required this.attachment,
      Uint8List? thumbnail,
      this.barsLimit = 100.0})
      : super(AudioValue()) {
    model = Provider.of<MessagingModel>(context, listen: false);
    audio = Provider.of<Audio>(context, listen: false);

    var durationString = attachment.attachment.metadata['duration'];
    if (durationString != null) {
      var milliseconds = (double.tryParse(durationString)! * 1000).toInt();
      value.duration = Duration(milliseconds: milliseconds);
      value.realDuration = Duration(milliseconds: milliseconds);
      value.pendingPercentage = 0;
    }

    var thumbnailFuture = thumbnail != null
        ? Future.value(thumbnail)
        : model.thumbnail(attachment).value.future;
    thumbnailFuture.then((t) {
      value.reducedAudioWave =
          AudioWaveform.fromBuffer(t).bars.reducedWaveform(limit: barsLimit);
      notifyListeners();
    });
  }

  Future<int> pause() async {
    final result = await audio.pause();
    if (result == 1) {
      value.playerState = PlayerState.paused;
      notifyListeners();
    }
    return result;
  }

  Future<int> stop() async {
    final result = await audio.stop();
    if (result == 1) {
      value.playerState = PlayerState.paused;
      value.position = const Duration();
      value.realDuration = const Duration();
      value.pendingPercentage = 0;
      notifyListeners();
    }
    return result;
  }

  Future<void> seek(Duration position) async {
    await audio.seek(position);
  }

  Future<void> play() async {
    if (value.playerState == PlayerState.paused) {
      await _resume();
      return;
    }

    context.loaderOverlay.show();
    try {
      var bytes = await model.decryptAttachment(attachment);
      await _play(bytes);
    } finally {
      context.loaderOverlay.hide();
    }
  }

  Future<void> _play(Uint8List bytes) async {
    await audio.play(
      bytes: bytes,
      onAttached: () {
        value.playerState = PlayerState.playing;
        notifyListeners();
      },
      onDetached: () {
        value.playerState = PlayerState.stopped;
        value.position = const Duration(); // reset position to start
        notifyListeners();
      },
      onDurationChanged: ((d) {
        value.realDuration = d;
        value.pendingPercentage = percentageOf(d.inMilliseconds,
            value.duration!.inMilliseconds, barsLimit.toInt());
        notifyListeners();
      }),
      onPositionChanged: ((p) {
        value.position = p;
        notifyListeners();
      }),
    );
  }

  Future<void> _resume() async {
    if (await audio.resume() == 1) {
      value.playerState = PlayerState.playing;
      notifyListeners();
    }
  }
}

class AudioWidget extends StatelessWidget {
  final AudioController controller;
  final double? widgetHeight;
  final Color initialColor;
  final Color progressColor;
  final Color backgroundColor;
  final bool showTimeRemaining;
  final double waveHeight;
  final double previewBarHeight;
  final double widgetWidth;
  final EdgeInsets padding;
  final double gap;
  final bool inbound;

  AudioWidget(
      {required this.controller,
      required this.initialColor,
      required this.progressColor,
      required this.backgroundColor,
      required this.inbound,
      this.padding = EdgeInsets.zero,
      this.gap = 0.8,
      this.widgetHeight,
      this.showTimeRemaining = true,
      required this.waveHeight,
      this.previewBarHeight = 40,
      required this.widgetWidth})
      : assert(gap > 0.0 && gap < 1.0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller,
        builder: (BuildContext context, AudioValue value, Widget? child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                          width: 40,
                          height: showTimeRemaining
                              ? 2 * widgetHeight!
                              : previewBarHeight,
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: _getPlayIcon(controller, value)),
                      if (showTimeRemaining && value.duration != null)
                        _getTimeRemaining(value),
                    ],
                  )
                ],
              ),
              Container(
                width: widgetWidth,
                margin: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                height: waveHeight,
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    value.reducedAudioWave.isNotEmpty
                        ? _getWaveBar(
                            context, value, value.reducedAudioWave, widgetWidth)
                        : const SizedBox(),
                    _getSliderOverlay(value, waveHeight),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _getTimeRemaining(AudioValue value) => Container(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
            (value.duration! - (value.position ?? const Duration()))
                .toString()
                .substring(2, 7),
            style: TextStyle(
                color: initialColor,
                fontWeight: FontWeight.w500,
                fontSize: 10.0)),
      );

  Widget _getSliderOverlay(AudioValue value, double thumbShapeHeight) {
    var _progress = _updateProgress(value);
    return Align(
      alignment: Alignment.center,
      child: SliderTheme(
        data: SliderThemeData(
            activeTrackColor: value.reducedAudioWave.isNotEmpty
                ? Colors.transparent
                : Colors.grey,
            inactiveTrackColor: value.reducedAudioWave.isNotEmpty
                ? Colors.transparent
                : Colors.blue,
            valueIndicatorColor: Colors.grey.shade200,
            trackShape: CustomTrackShape(),
            thumbShape: RectangleSliderThumbShapes(
                height: thumbShapeHeight,
                isPlaying: value.playerState == PlayerState.playing ||
                    value.playerState == PlayerState.paused)),
        child: Slider(
          onChanged: (v) {
            if (value.playerState == PlayerState.stopped) {
              // can't seek while stopped
              return;
            }
            final position = v * value.duration!.inMilliseconds;
            controller.seek(
              Duration(
                milliseconds: position.round(),
              ),
            );
          },
          min: 0,
          max: 100,
          value: _progress,
        ),
      ),
    );
  }

  Widget _getPlayIcon(AudioController controller, AudioValue value) {
    return value.isPlaying
        ? TextButton(
            onPressed: value.isPlaying ? () => controller.pause() : null,
            style: TextButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                alignment: Alignment.center),
            child: const Icon(
              Icons.pause,
              color: Colors.black,
              size: 20.0,
            ),
          )
        : TextButton(
            onPressed: () async {
              await controller.play();
            },
            style: TextButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: !inbound ? Colors.white : Colors.black,
                alignment: Alignment.center),
            child: Icon(
              Icons.play_arrow,
              color: !inbound ? outboundBgColor : Colors.white,
              size: 20.0,
            ),
          );
  }

  Widget _getWaveBar(BuildContext context, AudioValue value,
      List<double> reducedAudioWave, double width) {
    var _progress = _updateProgress(value);
    return Padding(
      padding: padding,
      child: WaveProgressBar(
        progressPercentage: _progress,
        alignment: Alignment.topCenter,
        listOfHeights: reducedAudioWave,
        initialColor: initialColor,
        progressColor: progressColor,
        backgroundColor: backgroundColor,
        width: width,
        height: widgetHeight,
        barHeightScaling: 0.5,
        gap: gap,
      ),
    );
  }

  double _updateProgress(AudioValue value) {
    var _progress = 0.0;
    if (value.position != null &&
        value.realDuration != null &&
        value.pendingPercentage != null &&
        value.position!.inMilliseconds > 0 &&
        value.position!.inMilliseconds < value.realDuration!.inMilliseconds) {
      _progress = (value.position!.inMilliseconds /
                      value.realDuration!.inMilliseconds) *
                  (100 + value.pendingPercentage!) >
              100
          ? 100
          : (value.position!.inMilliseconds /
                  value.realDuration!.inMilliseconds) *
              (100 + value.pendingPercentage!);
    }
    return _progress;
  }
}
