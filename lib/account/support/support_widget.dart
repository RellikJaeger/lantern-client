import 'package:url_launcher/url_launcher.dart';

import '../../common/common.dart';

class SupportWidget extends StatelessWidget {
  const SupportWidget({Key? key}) : super(key: key);

  final faqUrl = 'https://lantern.io/faq';

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'support'.i18n,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        //* Report
        ListItemFactory.settingsItem(
          icon: ImagePaths.alert,
          content: 'report_issue'.i18n,
          trailingArray: [
            mirrorLTR(context: context, child: const ContinueArrow())
          ],
          onTap: reportIssue,
        ),
        ListTile()
        ListItemFactory.settingsItem(
            content: 'lantern_user_forum'.i18n,
            icon: ImagePaths.alert,
            trailingArray: [
              mirrorLTR(
                context: context,
                child: const Padding(
                  padding: EdgeInsetsDirectional.only(start: 4.0),
                  child: CAssetImage(
                    path: ImagePaths.open,
                  ),
                ),
              )
            ],
            onTap: () {}),
        ListItemFactory.settingsItem(
          content: 'faq'.i18n,
          icon: ImagePaths.alert,
          trailingArray: [
            mirrorLTR(
              context: context,
              child: const Padding(
                padding: EdgeInsetsDirectional.only(start: 4.0),
                child: CAssetImage(
                  path: ImagePaths.open,
                ),
              ),
            )
          ],
          onTap: faqTap,
        ),
      ],
    );
  }

  // class methods and utils

  void reportIssue() async =>
      LanternNavigator.startScreen(LanternNavigator.SCREEN_SCREEN_REPORT_ISSUE);

  Future<void> faqTap() async {
    if (!await launchUrl(
      Uri.parse(faqUrl),
      mode: LaunchMode.externalApplication
    )) {
      throw Exception('Could not launch $faqUrl');
    }
  }
}
