import 'package:flutter/cupertino.dart';
import 'package:lantern/package_store.dart';

import 'account_menu.dart';

class AccountTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AccountMenu();
    // return BackButtonRespectingNavigator(
    //     onGenerateRoute: (RouteSettings settings) {
    //   WidgetBuilder builder;
    //   switch (settings.name) {
    //     case '/':
    //       builder = (BuildContext _) => AccountMenu();
    //       break;
    //     case routeProAccount:
    //       builder = (BuildContext _) => ProAccount();
    //       break;
    //     case routeSettings:
    //       builder = (BuildContext _) => Settings();
    //       break;
    //     case routeLanguage:
    //       builder = (BuildContext _) => Language();
    //       break;
    //     case routeAuthorizeDeviceForPro:
    //       builder = (BuildContext _) => AuthorizeDeviceForPro();
    //       break;
    //     case routeAuthorizeDeviceViaEmail:
    //       builder = (BuildContext _) => AuthorizeDeviceViaEmail();
    //       break;
    //     case routeAuthorizeDeviceViaEmailPin:
    //       builder = (BuildContext _) => AuthorizeDeviceViaEmailPin();
    //       break;
    //     case routeApproveDevice:
    //       builder = (BuildContext _) => ApproveDevice();
    //       break;
    //     default:
    //       throw Exception('unknown route ${settings.name}');
    //   }
    //   return MaterialPageRoute(builder: builder, settings: settings);
    // });
  }
}
