import 'package:email_validator/email_validator.dart';
import 'package:lantern/account/plans/payment_provider_button.dart';
import 'package:lantern/account/plans/plan_step.dart';
import 'package:lantern/account/plans/price_summary.dart';
import 'package:lantern/common/common.dart';

import 'constants.dart';

class Checkout extends StatefulWidget {
  final String id;

  Checkout({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout>
    with SingleTickerProviderStateMixin {
  final emailFieldKey = GlobalKey<FormState>();
  late final emailController = CustomTextEditingController(
    formKey: emailFieldKey,
    validator: (value) => EmailValidator.validate(value ?? '')
        ? null
        : 'Please enter a valid email address'.i18n,
  );

  final refCodeFieldKey = GlobalKey<FormState>();
  late final refCodeController = CustomTextEditingController(
    formKey: refCodeFieldKey,
    validator: (value) =>
        // only allow letters and numbers as well as 6 <= length <= 13
        value != null &&
                RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value) &&
                (6 <= value.characters.length && value.characters.length <= 13)
            ? null
            : 'Please enter a valid Referral code'.i18n,
  );

  final referralCode = '';
  var isRefCodeFieldShowing = false;
  var selectedPaymentProvider = paymentProviders[0];
  var loadingPercentage = 0;
  var submittedRefCode = false;
  late AnimationController animationController;
  late Animation pulseAnimation;

  @override
  void initState() {
    WebView.platform = AndroidWebView();

    animationController =
        AnimationController(vsync: this, duration: longAnimationDuration);
    animationController.repeat(reverse: true);
    pulseAnimation =
        Tween<double>(begin: 0.5, end: 2.0).animate(animationController);

    if (animationController.isCompleted) animationController.stop();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    refCodeController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      resizeToAvoidBottomInset: false,
      // TODO: translations
      title:
          'Lantern ${isPro == true ? 'Pro' : ''} Checkout', // TODO: Translations
      body: Form(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
            top: 24,
            bottom: 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // * Step 2
              const PlanStep(
                stepNum: '2',
                description: 'Enter email',
              ), // TODO: translations
              // * Email field
              Container(
                padding: const EdgeInsetsDirectional.only(
                  top: 8,
                  bottom: 8,
                ),
                child: Form(
                  key: emailFieldKey,
                  child: CTextField(
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.disabled,
                    label: 'Email'.i18n,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const CAssetImage(path: ImagePaths.email),
                  ),
                ),
              ),
              // * Referral Code field
              Visibility(
                visible: isRefCodeFieldShowing,
                child: Container(
                  padding: const EdgeInsetsDirectional.only(
                    top: 8,
                    bottom: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Form(
                          key: refCodeFieldKey,
                          child: CTextField(
                            enabled: !submittedRefCode,
                            controller: refCodeController,
                            autovalidateMode: AutovalidateMode.disabled,
                            // TODO: translations
                            label: 'Referral code',
                            keyboardType: TextInputType.text,
                            prefixIcon:
                                const CAssetImage(path: ImagePaths.star),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              submittedRefCode = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsetsDirectional.only(
                              start: 16.0,
                              end: 16.0,
                            ),
                            child: submittedRefCode &&
                                    refCodeFieldKey.currentState?.validate() ==
                                        true
                                ? Transform.scale(
                                    scale: pulseAnimation.value,
                                    child: const CAssetImage(
                                      path: ImagePaths.check_green,
                                    ),
                                  )
                                : CText(
                                    // TODO: translations
                                    'Apply'.toUpperCase(),
                                    style: tsButtonPink,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // * Add Referral code
              Visibility(
                visible: !isRefCodeFieldShowing,
                child: GestureDetector(
                  onTap: () async =>
                      setState(() => isRefCodeFieldShowing = true),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsetsDirectional.only(
                      top: 8,
                      bottom: 16,
                    ),
                    child: CText(
                      '+ Add Referral code ',
                      style: tsBody1,
                    ),
                  ),
                ),
              ),
              // * Step 3
              const PlanStep(
                stepNum: '3',
                description: 'Choose Payment Method',
              ), // TODO: translations
              //* Payment options
              Container(
                padding: const EdgeInsetsDirectional.only(top: 16, bottom: 16),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * Stripe
                    PaymentProviderButton(
                      logoPaths: [ImagePaths.visa, ImagePaths.mastercard],
                      onChanged: () => setState(
                        () => selectedPaymentProvider = 'stripe',
                      ),
                      selectedPaymentProvider: selectedPaymentProvider,
                      paymentType: 'stripe',
                    ),
                    // * BTC
                    PaymentProviderButton(
                      logoPaths: [ImagePaths.btc],
                      onChanged: () => setState(
                        () => selectedPaymentProvider = 'btc',
                      ),
                      selectedPaymentProvider: selectedPaymentProvider,
                      paymentType: 'btc',
                    )
                  ],
                ),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PriceSummary(
                    id: widget.id,
                  ),
                  // * Continue to Payment
                  Button(
                    disabled: emailController.value.text.isEmpty ||
                        emailFieldKey.currentState?.validate() == false,
                    text: 'Continue', // TODO: Translations
                    onPressed: () async {
                      if (selectedPaymentProvider == 'stripe') {
                        await context.pushRoute(
                          StripeCheckout(
                            email: emailController.text,
                            refCode: refCodeController.text,
                            id: widget.id,
                          ),
                        );
                      } else {
                        await context.pushRoute(
                          FullScreenDialogPage(
                            widget: Center(
                              child: Stack(
                                children: [
                                  // TODO: add BTCPAY call
                                  WebView(
                                    initialUrl: 'https://flutter.dev',
                                    onPageStarted: (url) {
                                      setState(() {
                                        loadingPercentage = 0;
                                      });
                                    },
                                    onProgress: (progress) {
                                      setState(() {
                                        loadingPercentage = progress;
                                      });
                                    },
                                    onPageFinished: (url) {
                                      setState(() {
                                        loadingPercentage = 100;
                                      });
                                    },
                                  ),
                                  if (loadingPercentage < 100)
                                    LinearProgressIndicator(
                                      value: loadingPercentage / 100.0,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
