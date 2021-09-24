import 'package:lantern/common/common.dart';

class CListTile extends StatelessWidget {
  final dynamic leading;
  final dynamic content;
  final Widget? trailing;
  final double height;
  final bool showDivider;
  final void Function()? onTap;

  CListTile({
    this.leading,
    required this.content,
    this.trailing,
    this.height = 72,
    this.showDivider = true,
    this.onTap,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => SizedBox(
        height: height,
        child: InkWell(
          onTap: onTap ?? () {},
          child: Ink(
            child: Container(
              decoration: !showDivider
                  ? null
                  : BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 1, color: grey3)),
                    ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (leading != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 4.0, end: 16.0),
                      child: buildLeading(),
                    ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      child: buildContent(),
                    ),
                  ),
                  if (trailing != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: trailing,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget? buildLeading() {
    if (leading == null) {
      return null;
    }

    if (leading is Widget) {
      return leading as Widget;
    }

    if (leading is String) {
      return CAssetImage(
        path: leading as String,
        size: 24,
      );
    }

    assert(false, 'unsupported leading type ${leading.runtimeType}');
    return null;
  }

  Widget buildContent() {
    if (content is Widget) {
      return content as Widget;
    }

    if (content is String) {
      return CText(content, style: tsBody1);
    }

    assert(false, 'unsupported content type ${content.runtimeType}');
    return const SizedBox();
  }
}
