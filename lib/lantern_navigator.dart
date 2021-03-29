import 'package:flutter/services.dart';

class LanternNavigator {
  static MethodChannel methodChannel =
      MethodChannel("navigator_method_channel");

  static startScreen(String screenName) {
    methodChannel.invokeMethod(
        'startScreen', <String, dynamic>{"screenName": screenName});
  }

  static const String SCREEN_PLANS = "SCREEN_PLANS";
  static const String SCREEN_INVITE_FRIEND = "SCREEN_INVITE_FRIEND";
  static const String SCREEN_DESKTOP_VERSION = "SCREEN_DESKTOP_VERSION";
  static const String SCREEN_FREE_YINBI = "SCREEN_FREE_YINBI";
  static const String SCREEN_YINBI_REDEMPTION = "SCREEN_YINBI_REDEMPTION";
}
