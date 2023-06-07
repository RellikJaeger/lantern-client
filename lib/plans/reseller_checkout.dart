import 'package:email_validator/email_validator.dart';
import 'package:lantern/plans/plan_details.dart';
import 'package:lantern/plans/tos.dart';
import 'package:lantern/common/common.dart';
import 'package:lantern/plans/utils.dart';

class ResellerCodeCheckout extends StatefulWidget {
  final bool isPro;
  ResellerCodeCheckout({
    Key? key,
    required this.isPro,
  }) : super(key: key);

  @override
  State<ResellerCodeCheckout> createState() => _ResellerCodeCheckoutState();
}

class _ResellerCodeCheckoutState extends State<ResellerCodeCheckout> {
  final emailFieldKey = GlobalKey<FormState>();
  late final emailController = CustomTextEditingController(
    formKey: emailFieldKey,
    validator: (value) => EmailValidator.validate(value ?? '')
        ? null
        : 'please_enter_a_valid_email_address'.i18n,
  );

  final resellerCodeFieldKey = GlobalKey<FormState>();
  late final resellerCodeController = CustomTextEditingController(
    formKey: resellerCodeFieldKey,
    validator: (value) => value != null &&
            // only allow letters, numbers and hyphens as well as length excluding dashes should be exactly 25 characters
            // TODO: reject our own referral code
            RegExp(r'^[a-zA-Z0-9-]*$').hasMatch(value) &&
            value.replaceAll('-', '').length == 25
        ? null
        : 'your_activation_code_is_invalid'.i18n,
  );

  var formIsValid = false;

  @override
  void dispose() {
    emailController.dispose();
    resellerCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final copy = 'register_for_pro'.i18n;
    return BaseScreen(
      title: 'lantern_${widget.isPro ? 'pro_' : ''}checkout'.i18n,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsetsDirectional.only(
          start: 16,
          end: 16,
          top: 24,
          bottom: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // * Step 2
            PlanStep(
              stepNum: '2',
              description: 'enter_email_and_activation_code'.i18n,
            ),
            // * Email field
            Container(
              padding: const EdgeInsetsDirectional.only(
                top: 8,
                bottom: 8,
              ),
              child: Form(
                onChanged: () => setState(() {
                  formIsValid = determineFormIsValid();
                }),
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
            // * Activation code field
            Container(
              padding: const EdgeInsetsDirectional.only(
                top: 8,
                bottom: 8,
              ),
              child: Form(
                onChanged: () {
                  final sLen = resellerCodeController.text.length;
                  final insertHyphen =
                      sLen == 5 || sLen == 11 || sLen == 17 || sLen == 23;
                  if (insertHyphen) {
                    final updatedText = resellerCodeController.text + '-';
                    resellerCodeController.value =
                        resellerCodeController.value.copyWith(
                      text: updatedText,
                      selection:
                          TextSelection.collapsed(offset: updatedText.length),
                    );
                  }
                  setState(() {
                    formIsValid = determineFormIsValid();
                  });
                },
                key: resellerCodeFieldKey,
                child: CTextField(
                  maxLength: 25 + 4, //accounting for dashes
                  controller: resellerCodeController,
                  autovalidateMode: AutovalidateMode.disabled,
                  label: 'Activation Code'.i18n,
                  keyboardType: TextInputType.text,
                  prefixIcon: const CAssetImage(path: ImagePaths.dots),
                  textCapitalization: TextCapitalization.characters,
                ),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                TOS(copy: copy),
                // * resellerCodeCheckout
                Button(
                  disabled: !formIsValid,
                  text: copy,
                  onPressed: () async {
                    context.loaderOverlay.show();
                    await sessionModel
                        .redeemResellerCode(
                          emailController.text,
                          resellerCodeController.text,
                        )
                        .timeout(
                          defaultTimeoutDuration,
                          onTimeout: () => onAPIcallTimeout(
                            code: 'redeemresellerCodeTimeout',
                            message: 'reseller_timeout'.i18n,
                          ),
                        )
                        .then((value) {
                      context.loaderOverlay.hide();
                      // TODO: Translations - the renewal success text depends on user status
                      CDialog.showInfo(
                        context,
                        iconPath: ImagePaths.lantern_logo,
                        size: 80,
                        title: 'renewal_success'.i18n,
                        description: 'reseller_success'.i18n,
                        actionLabel: 'Continue'.i18n,
                        dismissAction: () => context.router.pop(),
                      );
                    }).onError((error, stackTrace) {
                      context.loaderOverlay.hide();
                      CDialog.showError(
                        context,
                        error: e,
                        stackTrace: stackTrace,
                        description: (error as PlatformException)
                            .message
                            .toString(), // This is coming localized
                      );
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // returns true if we can submit
  bool determineFormIsValid() {
    // returns true if there is at least one empty field
    final anyFieldsEmpty = emailController.value.text.isEmpty ||
        resellerCodeController.value.text.isEmpty;

    // returns true if there is at least one invalid field
    final anyFieldsInvalid = emailFieldKey.currentState?.validate() == false ||
        resellerCodeFieldKey.currentState?.validate() == false;

    return (!anyFieldsEmpty && !anyFieldsInvalid);
  }
}