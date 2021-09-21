import 'package:lantern/account/account.dart';

import 'settings_item.dart';

class DeveloperSettingsTab extends StatelessWidget {
  DeveloperSettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sessionModel = context.watch<SessionModel>();

    return BaseScreen(
      title: 'Developer Settings'.i18n,
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.all(16.0),
            child: CTextWrap(
              'These settings are for development use only. Changing any setting will automatically stop and restart the application',
              style: tsBody3,
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.all(16.0),
            child: CTextWrap(
                'When Payment Test Mode is enabled, the app uses a single hardcoded user. You can make Stripe purchases using the number 4242 4242 4242 4242, an expiration date in the future, and any CVV.',
                style: tsBody3),
          ),
          SettingsItem(
            title: 'Payment Test Mode'.i18n,
            child: sessionModel.paymentTestMode(
                (BuildContext context, bool value, Widget? child) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 16.0),
                child: FlutterSwitch(
                  width: 44.0,
                  height: 24.0,
                  valueFontSize: 12.0,
                  padding: 2,
                  toggleSize: 18.0,
                  value: value,
                  onToggle: (bool newValue) {
                    sessionModel.setPaymentTestMode(newValue);
                  },
                ),
              );
            }),
          ),
          SettingsItem(
            title: 'Play Version'.i18n,
            child: sessionModel
                .playVersion((BuildContext context, bool value, Widget? child) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 16.0),
                child: FlutterSwitch(
                  width: 44.0,
                  height: 24.0,
                  valueFontSize: 12.0,
                  padding: 2,
                  toggleSize: 18.0,
                  value: value,
                  onToggle: (bool newValue) {
                    sessionModel.setPlayVersion(newValue);
                  },
                ),
              );
            }),
          ),
          SettingsItem(
            title: 'Force Country'.i18n,
            child: sessionModel.forceCountry(
                (BuildContext context, String value, Widget? child) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 16.0),
                child: DropdownButton<String>(
                  value: value,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: iconSize,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    sessionModel
                        .setForceCountry(newValue == '' ? null : newValue);
                  },
                  items: <String>['', 'CN', 'IR', 'US']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: CText(value, style: tsBody1),
                    );
                  }).toList(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
