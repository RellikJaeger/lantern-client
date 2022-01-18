import 'package:lantern/messaging/messaging.dart';

class CImageViewer extends ViewerWidget {
  final Function loadImageFile;
  @override
  final Widget? title;
  @override
  final List<Widget>? actions;
  @override
  final Map<String, dynamic>? metadata;

  CImageViewer({
    required this.loadImageFile,
    this.title,
    this.actions,
    this.metadata,
  }) : super();

  @override
  State<StatefulWidget> createState() => CImageViewerState();
}

class CImageViewerState extends ViewerState<CImageViewer> {
  BasicMemoryImage? image;

  @override
  void initState() {
    super.initState();
    widget.loadImageFile().then((bytes) {
      BasicMemoryImage? newImage = BasicMemoryImage(bytes);
      setState(() => image = newImage);
    });
  }

  @override
  bool ready() => image != null;

  @override
  Widget body(BuildContext context) => Align(
        alignment: Alignment.center,
        child: InteractiveViewer(
          child: image!,
        ),
      );
}
