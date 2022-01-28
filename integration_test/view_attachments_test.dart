import 'integration_test_common.dart';
import 'integration_test_constants.dart';

Future<void> main() async {
  late FlutterDriver driver;
  final testName = 'view_attachments';

  setUpAll(() async {
    // Connect to a running Flutter application instance.
    driver = await FlutterDriver.connect(timeout: const Duration(seconds: 30));
    await driver.initScreenshotsDirectory(testName);
  });

  tearDownAll(() async {
    await driver.close();
  });

  group(testName, () {
    test(
      'View an image',
      () async {
        await driver.resetFlagsAndEnrollAgain(skipScreenshot: true);

        print('tap to enter conversation');
        // TODO: ONLY WORKS WITH A SINGLE MESSAGE IN CHATS
        await driver.tapType(
          'ListItemFactory',
          overwriteTimeout: defaultWaitTimeout,
        );

        print('tap on image attachment');
        await driver.tapType('ImageAttachment');
      },
      timeout: const Timeout(Duration(minutes: 5)),
    );
    test(
      'View a video',
      () async {
        await driver.goBack();

        print('tap on video attachment');
        await driver.tapType(
          'VideoAttachment',
          overwriteTimeout: longWaitTimeout,
        );
      },
      timeout: const Timeout(Duration(minutes: 5)),
    );
  });
}
