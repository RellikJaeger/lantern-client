import 'package:lantern/account/account.dart';

import '../common/ui/continue_arrow.dart';

class SettingsItem extends StatelessWidget {
  late final String? icon;
  late final Color? iconColor;
  late final String? title;
  final bool showArrow;
  final Widget? child;
  final void Function(BuildContext context)? openInfoDialog;
  final void Function()? onTap;

  SettingsItem(
      {this.icon,
      this.iconColor,
      this.title,
      this.showArrow = false,
      this.openInfoDialog,
      this.onTap,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 72,
        child: InkWell(
          onTap: onTap ?? () {},
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 16),
                    child: CAssetImage(
                      path: icon!,
                      size: 24,
                      color: iconColor,
                    ),
                  ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    child: Row(
                      children: [
                        if (title != null)
                          Flexible(
                            child: Tooltip(
                              message: title!,
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(bottom: 1),
                                child: CText(
                                  title!,
                                  overflow: TextOverflow.ellipsis,
                                  style: tsSubtitle1Short,
                                ),
                              ),
                            ),
                          ),
                        if (openInfoDialog != null)
                          InkWell(
                            onTap: () {
                              openInfoDialog!(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: CAssetImage(
                                path: ImagePaths.info_icon,
                                size: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (child != null) child!,
                      if (showArrow) const ContinueArrow(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      CVerticalDivider(height: 1),
    ]);
  }
}
