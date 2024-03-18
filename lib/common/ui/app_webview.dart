import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_windows_webview/flutter_windows_webview.dart';
import 'package:lantern/common/common.dart';
import 'package:lantern/common/common_desktop.dart';
import 'package:lantern/plans/utils.dart';

@RoutePage(name: 'AppWebview')
class AppWebView extends StatefulWidget {
  final String url;

  const AppWebView({
    super.key,
    required this.url,
  });

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  final InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: false,
    javaScriptEnabled: true,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: false,
    underPageBackgroundColor: Colors.white,
    allowBackgroundAudioPlaying: false,
    allowFileAccessFromFileURLs: true,
    preferredContentMode: UserPreferredContentMode.MOBILE,
  );

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "",
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
        initialSettings: settings,
      ),
    );
  }
}

class AppBrowser extends InAppBrowser {
  Future<void> Function()? _onLoadStop;

  AppBrowser();

  @override
  Future onBrowserCreated() async {
    print("Browser created");
  }

  @override
  Future onLoadStart(url) async {
    print("Started displaying $url");
  }

  @override
  Future onLoadStop(url) async {
    print("Stopped displaying $url");
    this._onLoadStop?.call();
  }

  @override
  void onReceivedError(WebResourceRequest request, WebResourceError error) {
    print("Can't load ${request.url}.. Error: ${error.description}");
  }

  @override
  void onProgressChanged(progress) {
    print("Progress: $progress");
  }

  @override
  void onExit() {
    print("Browser closed");
  }

  static Future<void> launchMacWebview(
      String url, Future<void> Function() cb) async {
    final AppBrowser browser = AppBrowser(cb);
    browser._onLoadStop = cb;
    final settings = InAppBrowserClassSettings(
        browserSettings: InAppBrowserSettings(hideUrlBar: true),
        webViewSettings: InAppWebViewSettings(
            javaScriptEnabled: true, isInspectable: kDebugMode));
    await browser.openUrlRequest(
        urlRequest: URLRequest(url: WebUri(url)), settings: settings);
  }

  static Future<void> launchWindowsWebview(
      String url, Future<void> Function() cb) async {
    FlutterWindowsWebview().launchWebview(url);
  }
}
