import 'package:lantern/messaging/messaging.dart';
import 'package:lantern/vpn/vpn.dart';

import 'signaling.dart';

class Call extends StatefulWidget {
  final Contact contact;
  final MessagingModel model;
  final Session? initialSession;

  Call({required this.contact, required this.model, this.initialSession})
      : super();

  @override
  _CallState createState() => _CallState();
}

class _CallState extends State<Call> with WidgetsBindingObserver {
  late Future<Session> session;
  late Signaling signaling;
  var closed = false;
  var isPanelShowing = false;
  var isVerified = false;
  var fragmentStatusMap = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    signaling = widget.model.signaling;
    signaling.addListener(onSignalingStateChange);

    // initialize fragment - status map after breaking down numericFingerprint in groups of 5
    humanizeVerificationNum(widget.contact.numericFingerprint).asMap().forEach(
        (key, value) =>
            fragmentStatusMap[key] = {'fragment': value, 'isConfirmed': false});

    if (widget.initialSession != null) {
      session = Future.value(widget.initialSession!);
    } else {
      session = signaling.call(
        peerId: widget.contact.contactId.id,
        media: 'audio',
        onError: () {
          showConfirmationDialog(
              context: context,
              title: 'unable_to_complete_call'.i18n,
              explanation: 'please_try_again'.i18n,
              agreeText: 'close'.i18n,
              agreeAction: () async {
                signaling.bye(await session);
              });
        },
      );
    }
  }

  @override
  void dispose() async {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    signaling.removeListener(onSignalingStateChange);
    signaling.bye(await session);
  }

  void onSignalingStateChange() async {
    if (signaling.value.callState == CallState.Bye) {
      if (!closed) {
        Navigator.pop(context, isVerified);
        closed = true;
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        notifications.showInCallNotification(widget.contact);
        break;
      case AppLifecycleState.resumed:
        break;
      default:
        break;
    }
  }

  String getCallStatus(CallState callState) {
    switch (callState) {
      case CallState.Connected:
        return 'Connected'.i18n;
      case CallState.Bye:
        return 'Disconnecting'
            .i18n; // TODO: this shows up very briefly on start of call (normal?)
      default:
        return 'Connecting'.i18n;
    }
  }

  void handleTapping({required int key}) {
    var _status = fragmentStatusMap[key]['isConfirmed'];
    markFragments(!_status, key);
    setState(() => isVerified = fragmentsAreVerified());
    if (isVerified) {
      markAsVerified();
    }
  }

  // returns true if all the fragments have been verified
  bool fragmentsAreVerified() {
    return !fragmentStatusMap.entries
        .any((element) => element.value['isConfirmed'] == false);
  }

  void handleVerifyButtonPress() async {
    if (isVerified) {
      markFragments(false, null); // mark all fragments as unverified
      isVerified = false;
    } else {
      markFragments(true, null); // mark all fragments as verified
      isVerified = true;
      markAsVerified();
    }
  }

  void markAsVerified() async {
    var model = context.watch<MessagingModel>();
    await model.markDirectContactVerified(widget.contact.contactId.id);
  }

  void markFragments(bool value, int? key) {
    // mark one fragment
    if (key != null) {
      setState(() {
        fragmentStatusMap[key]['isConfirmed'] = value;
      });
    } else {
      // mark all fragments
      setState(() {
        fragmentStatusMap.updateAll(
            (key, el) => {'fragment': el['fragment'], 'isConfirmed': value});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: signaling,
        builder: (BuildContext context, SignalingState signalingState,
            Widget? child) {
          return SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                color: black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*
                   * Avatar, title and call status
                   */
                  Expanded(
                      child: isPanelShowing
                          ? Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 24.0, top: 40.0, bottom: 24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsetsDirectional.all(8.0),
                                    child: CustomAvatar(
                                        messengerId:
                                            widget.contact.contactId.id,
                                        displayName: widget
                                            .contact.displayNameOrFallback,
                                        customColor: grey5),
                                  ),
                                  renderTitle()
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsetsDirectional.all(8.0),
                                  child: CustomAvatar(
                                      messengerId: widget.contact.contactId.id,
                                      displayName:
                                          widget.contact.displayNameOrFallback,
                                      customColor: grey5,
                                      radius: 80),
                                ),
                                renderTitle()
                              ],
                            )),
                  /*
                   * Verification panel
                   */
                  if (isPanelShowing)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsetsDirectional.only(
                                top: 30, bottom: 30),
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: grey5,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: white,
                                      ),
                                      onPressed: () {
                                        setState(() => isPanelShowing = false);
                                        if (!fragmentsAreVerified() ||
                                            !isVerified) {
                                          markFragments(false,
                                              null); // mark all fragments as unverified since we closed the modal before finishing verification
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 24,
                                          end: 24,
                                          top: 32,
                                          bottom: 24),
                                      child: CText(
                                          isVerified
                                              ? 'verification_panel_success'
                                                  .i18n
                                                  .fill([
                                                  widget.contact
                                                      .displayNameOrFallback
                                                ])
                                              : 'verification_panel_pending'
                                                  .i18n
                                                  .fill([
                                                  widget.contact
                                                      .displayNameOrFallback
                                                ]),
                                          style:
                                              tsBody1.copiedWith(color: grey3)),
                                    ),
                                  ],
                                ),
                                /*
                                * Verification number
                                */
                                Container(
                                    padding: const EdgeInsetsDirectional.only(
                                        bottom: 24.0),
                                    child: Wrap(
                                      children: [
                                        ...fragmentStatusMap.entries
                                            .map((entry) => GestureDetector(
                                                  key: ValueKey(entry.key),
                                                  onTap: () => handleTapping(
                                                      key: entry.key),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .only(
                                                            start: 10.0,
                                                            end: 10.0),
                                                    child: CText(
                                                        entry.value['fragment']
                                                            .toString(),
                                                        style: entry.value[
                                                                'isConfirmed']
                                                            ? tsHeading1.copiedWith(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                color: grey4)
                                                            : tsHeading1
                                                                .copiedWith(
                                                                    color:
                                                                        white)),
                                                  ),
                                                ))
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      bottom: 24.0),
                                  child: Button(
                                    tertiary: true,
                                    width: 200,
                                    iconPath: isVerified
                                        ? null
                                        : ImagePaths.verified_user,
                                    text: isVerified
                                        ? 'undo_verification'.i18n
                                        : 'mark_as_verified'.i18n,
                                    onPressed: () => handleVerifyButtonPress(),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  /*
                   * Verify button
                   */
                  if (!isPanelShowing)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsetsDirectional.all(24.0),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              RoundButton(
                                icon: CAssetImage(
                                    path: ImagePaths.verified_user,
                                    color: white),
                                backgroundColor: grey5,
                                onPressed: () =>
                                    setState(() => isPanelShowing = true),
                              ),
                              Transform.translate(
                                offset: const Offset(0.0, 30.0),
                                child: CText('verification'.i18n,
                                    style: tsBody1.copiedWith(color: white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  /*
                   * Controls
                   */
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.all(24.0),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              RoundButton(
                                icon: CAssetImage(
                                    path: ImagePaths.speaker,
                                    color: signalingState.speakerphoneOn
                                        ? grey5
                                        : white),
                                backgroundColor: signalingState.speakerphoneOn
                                    ? white
                                    : grey5,
                                onPressed: () {
                                  signaling.toggleSpeakerphone();
                                },
                              ),
                              Transform.translate(
                                offset: const Offset(0.0, 30.0),
                                child: CText(
                                    signalingState.speakerphoneOn
                                        ? 'speaker_on'.i18n
                                        : 'speaker'.i18n,
                                    style: tsBody1.copiedWith(color: white)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.all(24.0),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              RoundButton(
                                icon: CAssetImage(
                                    path: ImagePaths.mute,
                                    color:
                                        signalingState.muted ? grey5 : white),
                                backgroundColor:
                                    signalingState.muted ? white : grey5,
                                onPressed: () {
                                  signaling.toggleMute();
                                },
                              ),
                              Transform.translate(
                                offset: const Offset(0.0, 30.0),
                                child: CText(
                                    signalingState.muted
                                        ? 'muted'.i18n
                                        : 'mute'.i18n,
                                    style: tsBody1.copiedWith(color: white)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.all(24.0),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              RoundButton(
                                icon:
                                    const CAssetImage(path: ImagePaths.hangup),
                                backgroundColor: indicatorRed,
                                onPressed: () async {
                                  signaling.bye(await session);
                                },
                              ),
                              Transform.translate(
                                offset: const Offset(0.0, 30.0),
                                child: CText('end_call'.i18n,
                                    style: tsBody1.copiedWith(color: white)),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  const Padding(
                      padding: EdgeInsetsDirectional.only(bottom: 40)),
                ],
              ),
            ),
          );
        });
  }

  // breaks the numericalFingerpint String into groups of 5
  List<dynamic> humanizeVerificationNum(String verificationNum) {
    final verificationNumList =
        widget.contact.numericFingerprint.characters.toList();
    var verificationFragments = [];
    // surely we can do this more efficiently but oh well
    for (var i = 0; i < verificationNumList.length; i += 5) {
      final fragment = verificationNumList
          .sublist(
              i,
              i + 5 > verificationNumList.length
                  ? verificationNumList.length
                  : i + 5)
          .join();
      verificationFragments.add(fragment);
    }
    return verificationFragments;
  }

  Column renderTitle() => Column(
          mainAxisAlignment: isPanelShowing
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          crossAxisAlignment: isPanelShowing
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Container(
              child: CText(
                widget.contact.displayNameOrFallback.isNotEmpty
                    ? widget.contact.displayNameOrFallback
                    : widget.contact.contactId.id,
                style: tsHeading1.copiedWith(color: white),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 80.0),
              child: CText(
                getCallStatus(signaling.value.callState),
                style: tsBody1.copiedWith(color: white),
              ),
            ),
          ]);
}
