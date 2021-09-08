import 'package:auto_route/auto_route.dart';
import 'package:lantern/config/transitions.dart';
import 'package:lantern/ui/index.dart';
import 'package:lantern/ui/widgets/account/device_linking/approve_device.dart';
import 'package:lantern/ui/widgets/account/device_linking/authorize_device_for_pro.dart';
import 'package:lantern/ui/widgets/account/device_linking/authorize_device_via_email.dart';
import 'package:lantern/ui/widgets/account/device_linking/authorize_device_via_email_pin.dart';
import 'package:lantern/ui/widgets/account/language.dart';
import 'package:lantern/ui/widgets/account/messaging/display_name.dart';
import 'package:lantern/ui/widgets/account/pro_account.dart';
import 'package:lantern/ui/widgets/account/settings.dart';

const account_tab_router = CustomRoute<void>(
  page: EmptyRouterPage,
  name: 'AccountRouter',
  path: 'account',
  children: [
    CustomRoute<void>(
        page: AccountTab,
        name: 'Account',
        path: '',
        transitionsBuilder: defaultTransition,
        durationInMilliseconds: defaultTransitionMillis,
        reverseDurationInMilliseconds: defaultTransitionMillis),
    CustomRoute<void>(
        page: ProAccount,
        name: 'ProAccount',
        path: 'proAccount',
        transitionsBuilder: defaultTransition,
        durationInMilliseconds: defaultTransitionMillis,
        reverseDurationInMilliseconds: defaultTransitionMillis),
    CustomRoute<void>(
        page: Settings,
        name: 'Settings',
        path: 'settings',
        transitionsBuilder: defaultTransition,
        durationInMilliseconds: defaultTransitionMillis,
        reverseDurationInMilliseconds: defaultTransitionMillis),
    CustomRoute<void>(
        page: Language,
        name: 'Language',
        path: 'language',
        transitionsBuilder: defaultTransition,
        durationInMilliseconds: defaultTransitionMillis,
        reverseDurationInMilliseconds: defaultTransitionMillis),
    CustomRoute<void>(
        page: AuthorizeDeviceForPro,
        name: 'AuthorizePro',
        path: 'authorizePro',
        transitionsBuilder: defaultTransition,
        durationInMilliseconds: defaultTransitionMillis,
        reverseDurationInMilliseconds: defaultTransitionMillis),
    CustomRoute<void>(
        page: AuthorizeDeviceViaEmail,
        name: 'AuthorizeDeviceEmail',
        path: 'authorizeDeviceEmail',
        transitionsBuilder: defaultTransition,
        durationInMilliseconds: defaultTransitionMillis,
        reverseDurationInMilliseconds: defaultTransitionMillis),
    CustomRoute<void>(
        page: AuthorizeDeviceViaEmailPin,
        name: 'AuthorizeDeviceEmailPin',
        path: 'authorizeDeviceEmailPin',
        transitionsBuilder: defaultTransition,
        durationInMilliseconds: defaultTransitionMillis,
        reverseDurationInMilliseconds: defaultTransitionMillis),
    CustomRoute<void>(
        page: ApproveDevice,
        name: 'ApproveDevice',
        path: 'approveDevice',
        transitionsBuilder: defaultTransition,
        durationInMilliseconds: defaultTransitionMillis,
        reverseDurationInMilliseconds: defaultTransitionMillis),
    CustomRoute<void>(
        page: DisplayName,
        name: 'DisplayName',
        path: 'displayName',
        transitionsBuilder: defaultTransition,
        durationInMilliseconds: defaultTransitionMillis,
        reverseDurationInMilliseconds: defaultTransitionMillis),
  ],
);
