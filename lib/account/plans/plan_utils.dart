import 'package:lantern/common/common.dart';

List<Map<String, dynamic>> formatCachedPlans(String cachedPlans) {
  // transform the String cached in db to a workable format
  // ignore: omit_local_variable_types
  List<Map<String, dynamic>> plans = [];

  if (cachedPlans.isEmpty) return [];
  try {
    final plansMap = jsonDecode(cachedPlans) as Map;
    plansMap.forEach((key, value) => plans.add(value));
  } on FormatException catch (e) {
    print(e);
    return [];
  }
  return plans;
}

void onAPIcallTimeout({code, message}) {
  throw PlatformException(
    code: code,
    message: message,
  );
}

String localizeCachingError(error) =>
    (error as PlatformException).message.toString();

// TODO: we build a pollForUpdates logic instead of having a constant duration
const defaultTimeoutDuration = Duration(seconds: 30);

// returns true if there are any Plans entries where { level: 'platinum' }
// depends on where the plans are fetched from
bool isPlatinumAvailable(String cachedPlans) {
  if (cachedPlans == '') return false;

  final cachedPlansMap = jsonDecode(cachedPlans) as Map;
  final anyPlatinumLevels = cachedPlansMap.entries.map((p) {
    final availablePlan = p.value as Map;
    return availablePlan['level'] == 'platinum';
  });
  return anyPlatinumLevels.contains(true);
}

// returns true if the cached user status is platinum
// is independent of where the plans are fetched from
bool isUserLevelPlatinum(String userLevel) {
  return userLevel == 'platinum';
}

String getPurchaseDialogTitle(String userLevel) {
  // TODO: fix
  final isRenewal = true;
  if (isRenewal) {
    return 'renewal_success_title'.i18n;
  }
  return isUserLevelPlatinum(userLevel)
      ? 'platinum_purchase_success_title'.i18n
      : 'pro_purchase_success_title'.i18n;
}

String getPurchaseDialogText(String userLevel) {
  // TODO: fix
  final isRenewal = true;
  if (isRenewal) {
    return isUserLevelPlatinum(userLevel)
        ? 'platinum_renewal_success_description'.i18n
        : 'pro_renewal_success_description'.i18n;
  }
  return isUserLevelPlatinum(userLevel)
      ? 'platinum_purchase_success_descripion'.i18n
      : 'pro_purchase_success_description'.i18n;
}
