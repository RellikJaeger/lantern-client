import 'package:lantern/common/common.dart';

import 'purchase_constants.dart';

class PlanCard extends StatelessWidget {
  final List<Map<String, Object>> plans;
  final String id;
  final bool isPro;
  final bool isCN;
  final bool isPlatinum;

  const PlanCard({
    required this.plans,
    required this.id,
    required this.isPro,
    required this.isCN,
    required this.isPlatinum,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPlan = plans.firstWhere((p) => p['id'] == id);
    final description = selectedPlan['description'] as String;

    // Get currency
    final currencyObject = selectedPlan['price'] as Map;
    final currency = currencyObject.entries.first.key.toString().toUpperCase();

    // Get price per month and year
    final pricePerYear =
        currencyFormatter.format(currencyObject.entries.first.value);
    final pricePerMonthObject = selectedPlan['expectedMonthlyPrice'] as Map;

    final pricePerMonth =
        currencyFormatter.format(pricePerMonthObject.entries.first.value);

    final isBestValue = selectedPlan['bestValue'] as bool;
    final renewalBonus = selectedPlan['renewalBonus'] as Map;

    return CInkWell(
      onTap: () async {
        final isPlayVersion = await sessionModel.getPlayVersion();

        // * Play version
        if (isPlayVersion) {
          await sessionModel.submitGooglePlay(id).onError((error, stackTrace) {
            // on failure
            CDialog.showError(
              context,
              error: e,
              stackTrace: stackTrace,
              description:
                  (error as PlatformException).message ?? error.toString(),
            );
          });
        } else {
          // * Proceed to our own Checkout
          await context.pushRoute(
            Checkout(
              plans: plans,
              id: id,
              isPro: isPro,
              isPlatinum: isPlatinum,
            ),
          );
        }
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Card(
            color: isBestValue ? pink1 : white,
            shadowColor: grey2,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2.0,
                color: isBestValue ? pink4 : grey2,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: isBestValue ? 3 : 1,
            child: Container(
              padding: const EdgeInsetsDirectional.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // * Plan name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        determinePlanDescription(
                          description,
                          renewalBonus,
                          isPro,
                        ),
                        style: tsSubtitle2.copiedWith(
                          color: pink3,
                        ),
                      ),
                      const CAssetImage(
                        path: ImagePaths.keyboard_arrow_right,
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsetsDirectional.only(top: 6)),
                  // * Price per month
                  Row(
                    children: [
                      CText('$currency $pricePerMonth / ', style: tsSubtitle1),
                      CText('month'.i18n, style: tsBody1),
                    ],
                  ),
                  // * Price per year
                  Row(
                    children: [
                      CText(
                        'currency_price_billed_one_time'
                            .i18n
                            .fill([currency, pricePerYear]),
                        style: tsBody2.copiedWith(color: grey5),
                      ),
                    ],
                  ),
                  // * Plan details if in China
                  if (isCN == true)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...chinaPlanDetails[isBestValue ? 1 : 0].map(
                            (d) => Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    end: 8.0,
                                  ),
                                  child: CAssetImage(
                                    path: isBestValue
                                        ? d == chinaPlanDetails[1].first
                                            ? ImagePaths.check_black
                                            : ImagePaths.add
                                        : ImagePaths.check_black,
                                    size: 16,
                                  ),
                                ),
                                CText(d, style: tsBody1),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
          if (isBestValue)
            Transform.translate(
              offset: const Offset(0.0, 10.0),
              child: Card(
                color: yellow4,
                shadowColor: grey2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: isBestValue ? 3 : 1,
                child: Container(
                  padding: const EdgeInsetsDirectional.only(
                    start: 12.0,
                    top: 0.0,
                    end: 12.0,
                    bottom: 4.0,
                  ),
                  child: CText(
                    'most_popular'.i18n,
                    style: tsBody1,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  String determinePlanDescription(
    String description,
    Map? renewalBonus,
    bool isPro,
  ) {
    if (renewalBonus == null) {
      return description;
    }
    final renewalMonths = renewalBonus['months'];
    final renewalGlobal = '$description $renewalMonths ' +
        '${renewalMonths == 1 ? 'month' : 'months'}'.i18n;
    return (!isCN && isPro) ? renewalGlobal : description;
  }
}
