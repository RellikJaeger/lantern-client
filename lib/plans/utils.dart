import 'package:lantern/common/common.dart';

const defaultTimeoutDuration = Duration(seconds: 10);

const lanternStarLogo = CAssetImage(
  path: ImagePaths.lantern_star,
  size: 72,
);

final featuresList = [
  'unlimited_data'.i18n,
  'faster_data_centers'.i18n,
  'no_logs'.i18n,
  'connect_up_to_3_devices'.i18n,
  'no_ads'.i18n,
];

void onAPIcallTimeout({code, message}) {
  throw PlatformException(
    code: code,
    message: message,
  );
}

void showSuccessDialog(BuildContext context, bool isPro, [bool? isReseller]) {
  String description, title;
  if (isReseller != null && isReseller) {
    title = 'renewal_success'.i18n;
    description = 'reseller_success'.i18n;
  } else if (isPro) {
    title = 'renewal_success'.i18n;
    description = 'pro_renewal_success_description'.i18n;
  } else {
    title = 'pro_purchase_success'.i18n;
    description = 'pro_purchase_success_descripion'.i18n;
  }
  CDialog.showInfo(
    context,
    icon: lanternStarLogo,
    title: title,
    description: description,
    actionLabel: 'continue_to_pro'.i18n,
    agreeAction: () async {
      await context.pushRoute(Home());
      return true;
    },
  );
}
