///
/// [Author] Alex (https://github.com/Alex525)
/// [Date] 2020/3/31 15:39
///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';

class AssetPicker<A, P> extends StatelessWidget {
  const AssetPicker({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final AssetPickerBuilderDelegate<A, P> builder;

  /// Static method to push with the navigator.
  /// 跳转至选择器的静态方法
  static Future<List<AssetEntity>?> pickAssets(
    BuildContext context, {
    List<AssetEntity>? selectedAssets,
    int maxAssets = 9,
    int pageSize = 80,
    int pathThumbSize = 80,
    int gridCount = 2,
    RequestType requestType = RequestType.image,
    List<int>? previewThumbSize,
    SpecialPickerType? specialPickerType,
    Color? themeColor,
    ThemeData? pickerTheme,
    SortPathDelegate? sortPathDelegate,
    AssetsPickerTextDelegate? textDelegate,
    FilterOptionGroup? filterOptions,
    WidgetBuilder? specialItemBuilder,
    IndicatorBuilder? loadingIndicatorBuilder,
    SpecialItemPosition specialItemPosition = SpecialItemPosition.none,
    bool allowSpecialItemWhenEmpty = false,
    Curve routeCurve = Curves.easeIn,
    Duration routeDuration = const Duration(milliseconds: 300),
  }) async {
    if (maxAssets < 1) {
      throw ArgumentError(
        'maxAssets must be greater than 1.',
      );
    }
    if (pageSize % gridCount != 0) {
      throw ArgumentError(
        'pageSize must be a multiple of gridCount.',
      );
    }
    if (pickerTheme != null && themeColor != null) {
      throw ArgumentError(
        'Theme and theme color cannot be set at the same time.',
      );
    }
    if (specialPickerType != null && requestType != RequestType.image) {
      throw ArgumentError(
        'specialPickerType and requestType cannot be set at the same time.',
      );
    } else {
      if (specialPickerType == SpecialPickerType.wechatMoment) {
        requestType = RequestType.common;
      }
    }
    if ((specialItemBuilder == null &&
            specialItemPosition != SpecialItemPosition.none) ||
        (specialItemBuilder != null &&
            specialItemPosition == SpecialItemPosition.none)) {
      throw ArgumentError('Custom item didn\'t set properly.');
    }

    try {
      final bool isPermissionGranted = await PhotoManager.requestPermission();
      if (isPermissionGranted) {
        final DefaultAssetPickerProvider provider = DefaultAssetPickerProvider(
          maxAssets: maxAssets,
          pageSize: pageSize,
          pathThumbSize: pathThumbSize,
          selectedAssets: selectedAssets,
          requestType: requestType,
          sortPathDelegate: sortPathDelegate,
          filterOptions: filterOptions,
          routeDuration: routeDuration,
        );
        final Widget picker =
            ChangeNotifierProvider<DefaultAssetPickerProvider>.value(
          value: provider,
          child: AssetPicker<AssetEntity, AssetPathEntity>(
            key: Constants.pickerKey,
            builder: DefaultAssetPickerBuilderDelegate(
              provider: provider,
              gridCount: gridCount,
              textDelegate: textDelegate,
              themeColor: themeColor,
              pickerTheme: pickerTheme,
              previewThumbSize: previewThumbSize,
              specialPickerType: specialPickerType,
              specialItemPosition: specialItemPosition,
              specialItemBuilder: specialItemBuilder,
              loadingIndicatorBuilder: loadingIndicatorBuilder,
              allowSpecialItemWhenEmpty: allowSpecialItemWhenEmpty,
            ),
          ),
        );
        final List<AssetEntity>? result = await Navigator.of(
          context,
          rootNavigator: true,
        ).push<List<AssetEntity>>(
          SlidePageTransitionBuilder<List<AssetEntity>>(
            builder: picker,
            transitionCurve: routeCurve,
            transitionDuration: routeDuration,
          ),
        );
        return result;
      } else {
        return null;
      }
    } catch (e) {
      realDebugPrint('Error when calling assets picker: $e');
      return null;
    }
  }

  /// Register observe callback with assets changes.
  /// 注册资源（图库）变化的监听回调
  static void registerObserve([ValueChanged<MethodCall>? callback]) {
    if (callback == null) {
      return;
    }
    try {
      PhotoManager.addChangeCallback(callback);
      PhotoManager.startChangeNotify();
    } catch (e) {
      realDebugPrint('Error when registering assets callback: $e');
    }
  }

  /// Unregister the observation callback with assets changes.
  /// 取消注册资源（图库）变化的监听回调
  static void unregisterObserve([ValueChanged<MethodCall>? callback]) {
    if (callback == null) {
      return;
    }
    try {
      PhotoManager.removeChangeCallback(callback);
      PhotoManager.stopChangeNotify();
    } catch (e) {
      realDebugPrint('Error when unregistering assets callback: $e');
    }
  }

  // TODO(kallirroi): themeData definition
  //
  /// Build a dark theme according to the theme color.
  /// 通过主题色构建一个默认的暗黑主题
  static ThemeData themeData(Color themeColor) {
    return ThemeData.dark().copyWith(
      buttonColor: themeColor,
      backgroundColor: Colors.black,
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      primaryColorBrightness: Brightness.dark,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
      accentColor: themeColor,
      accentColorBrightness: Brightness.dark,
      canvasColor: Colors.grey[850],
      scaffoldBackgroundColor: Colors.black,
      bottomAppBarColor: Colors.black,
      cardColor: Colors.black,
      highlightColor: Colors.transparent,
      toggleableActiveColor: themeColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: themeColor,
        selectionColor: themeColor.withAlpha(100),
        selectionHandleColor: themeColor,
      ),
      indicatorColor: themeColor,
      appBarTheme: const AppBarTheme(
        brightness: Brightness.dark,
        elevation: 0,
      ),
      colorScheme: const ColorScheme(
        primary: Colors.black,
        primaryVariant: Colors.black,
        secondary: Colors.white,
        secondaryVariant: Colors.grey,
        background: Colors.black,
        surface: Colors.black,
        brightness: Brightness.dark,
        error: Color(0xffcf6679),
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return builder.build(context);
  }
}
