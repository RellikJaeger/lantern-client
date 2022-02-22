import 'integration_test_common.dart';
import 'integration_test_constants.dart';

Future<void> main() async {
  late FlutterDriver driver;
  final testName = 'add_via_secure_number';

  setUpAll(() async {
    // Connect to a running Flutter application instance.
    driver = await connect();
    await driver.initScreenshotsDirectory(testName);
  });

  tearDownAll(() async {
    await driver.close();
  });

  group(testName, () {
    test(
      'Send a message to another secure number',
      () async {
        await driver.screenshotCurrentView();

        await driver.tapFAB();

        await driver.tapText(
          await driver.requestData('add_via_chat_number'),
          overwriteTimeout: longWaitTimeout,
        );

        await driver.waitForSeconds(2);

        print('entering secure chat number');
        await driver.captureScreenshotDuringFuture(
          futureToScreenshot: driver.enterText(
            textThisNumber,
            timeout: longWaitTimeout,
          ),
          screenshotTitle: 'entering_secure_number',
        );

        await driver.tapText(
          (await driver.requestData('start_chat')).toUpperCase(),
          overwriteTimeout: longWaitTimeout,
        );

        await driver.enterText(contactNewName);

        await driver.waitForSeconds(2);

        await driver.tapText((await driver.requestData('Done')).toUpperCase());
      },
      timeout: const Timeout(Duration(minutes: 5)),
    );
  });
}
