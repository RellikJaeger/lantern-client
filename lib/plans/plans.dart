import 'package:lantern/common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:lantern/i18n/localization_constants.dart';
import 'package:lantern/plans/plan_details.dart';
import 'package:lantern/plans/utils.dart';

final featuresList = [
  'unlimited_data'.i18n,
  'faster_data_centers'.i18n,
  'no_logs'.i18n,
  'connect_up_to_3_devices'.i18n,
  'no_ads'.i18n,
];

class PlansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FullScreenDialog(widget: sessionModel
        .proUser((BuildContext context, bool proUser, Widget? child) {
      return sessionModel.plans(builder: (
        context,
        Iterable<PathAndValue<Plan>> plans,
        Widget? child,
      ) {
        if (plans.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CAssetImage(
                  path: ImagePaths.error,
                  size: 100,
                  color: grey5,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(24.0),
                  child: CText(
                    'error_fetching_plans'.i18n,
                    style: tsBody1,
                  ),
                ),
              ],
            ),
          );
        }

        return StatefulBuilder(
            builder: (context, setState) => Center(
                  child: ListView(shrinkWrap: true, children: [
                    Container(
                        padding: const EdgeInsetsDirectional.only(
                            bottom: 25, start: 32, end: 16),
                        color: white,
                        child: Row(
                          children: [
                            Container(
                                padding:
                                    const EdgeInsetsDirectional.only(top: 25),
                                child: CAssetImage(
                                  path: ImagePaths.lantern_pro_logotype,
                                  size: 20,
                                )),
                            Spacer(),
                            Container(
                              padding:
                                  const EdgeInsetsDirectional.only(top: 20),
                              child: IconButton(
                                icon: mirrorLTR(
                                  context: context,
                                  child: CAssetImage(
                                    path: ImagePaths.cancel,
                                    color: black,
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context, null),
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                        child: Container(
                            color: white,
                            padding: const EdgeInsetsDirectional.only(
                              start: 32,
                              end: 32,
                              bottom: 24,
                            ),
                            child: Column(
                              children: [
                                // * Renewal text or upsell
                                if (proUser &&
                                    plans.last.value.renewalText != '')
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        bottom: 12.0),
                                    child: CText(
                                      plans.last.value.renewalText,
                                      style: tsBody1,
                                    ),
                                  ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsetsDirectional.only(
                                            bottom: 12.0,
                                          ),
                                          child: CDivider(),
                                        ),
                                        ...featuresList.map(
                                          (feature) => Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const CAssetImage(
                                                path: ImagePaths
                                                    .check_green_large,
                                                size: 24,
                                              ),
                                              CText(feature, style: tsBody1),
                                            ],
                                          ),
                                        ),
                                        const CDivider(height: 24),
                                      ]),
                                ),
                                // * Step
                                Container(
                                  padding: EdgeInsetsDirectional.only(
                                    top: 16.0,
                                    bottom: 16.0,
                                  ),
                                  child: PlanStep(
                                    stepNum: '1',
                                    description: 'choose_plan'.i18n,
                                  ),
                                ),
                                // * Card
                                if (plans != null)
                                  ...plans.map(
                                    (plan) => PlanCard(
                                      plan: plan.value,
                                      isPro: proUser,
                                    ),
                                  ),
                              ],
                            ))),
                    //]),
                    // * Footer
                    Stack(
                      children: [
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 2.0, color: grey3),
                            ),
                            color: grey1,
                          ),
                          child: GestureDetector(
                            onTap: () async => await context.pushRoute(
                              ResellerCodeCheckout(isPro: proUser),
                            ),
                            child: CText(
                              'Have a Lantern Pro activation code? Click here.',
                              style: tsBody1.copiedWith(color: grey5),
                            ),
                          ), // Translations
                        ),
                        Divider(
                          color: grey1,
                          height: 2,
                        ),
                      ],
                    ),
                  ]),
                ));
      });
    }));
  }
}
