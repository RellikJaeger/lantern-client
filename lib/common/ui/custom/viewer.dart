import 'package:lantern/messaging/messaging.dart';

/// Base class for widgets that allow viewing files like images and videos, for both Chat and Replica.
abstract class ViewerWidget extends StatefulWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Map<String, dynamic>? metadata;

  ViewerWidget({
    this.title,
    this.actions,
    this.metadata,
  });
}

/// Base class for state associated with ViewerWidgets. It is extended by CVideoViewer and CImageViewer, which in turn get extended by the respective Chat and Replica image/video rendering widgets. It handles orientation changes and compensates for a known Flutter bug in video orientation: https://github.com/flutter/flutter/issues/60327
abstract class ViewerState<T extends ViewerWidget> extends State<T>
    with WidgetsBindingObserver {
  bool showInfo = true;
  Orientation orientation = Orientation.portrait;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    // reset orientation
    orientation = Orientation.portrait;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  // didChangeMetrics(): Called when the application's dimensions change. For example, when a phone is rotated.
  @override
  void didChangeMetrics() {
    orientation = MediaQuery.of(context).orientation;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        orientation = MediaQuery.of(context).orientation;
      });
    });
  }

  bool ready();

  void handleLoader() {
    !ready()
        ? context.loaderOverlay.show(widget: spinner)
        : context.loaderOverlay.hide();
  }

  Widget body(BuildContext context);

  @override
  Widget build(BuildContext context) {
    handleLoader();
    return BaseScreen(
      title: widget.title,
      actions: widget.actions,
      padHorizontal: false,
      // we can keep this as is since the designs between Chat and Replica have been consolidated to have black background and white font color
      foregroundColor: white,
      backgroundColor: black,
      showAppBar: showInfo,
      body: GestureDetector(
        onTap: () => setState(() => showInfo = !showInfo),
        child: !showInfo && ready()
            ? Align(alignment: Alignment.center, child: body(context))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: !ready() ? Container() : body(context)),
                  widget.metadata?['ts'] ?? Container(),
                ],
              ),
      ),
    );
  }
}
