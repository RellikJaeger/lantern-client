import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:lantern/package_store.dart';
import 'package:lantern/ui/routes.dart';
import 'package:lantern/ui/widgets/custom_text_field.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../button.dart';

class AuthorizeDeviceViaEmail extends StatelessWidget {
  AuthorizeDeviceViaEmail({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var sessionModel = context.watch<SessionModel>();

    return BaseScreen(
      title: 'Authorize Device via Email'.i18n,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(top: 32),
                child: CustomTextField(
                  controller: emailController,
                  label: 'Email'.i18n,
                  helperText:
                      'Enter the email associated with your Pro account'.i18n,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  validator: (value) => EmailValidator.validate(value ?? '')
                      ? null
                      : 'Please enter a valid email address'.i18n,
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsetsDirectional.only(bottom: 32),
                child: Button(
                  width: 200,
                  text: 'Submit'.i18n,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.loaderOverlay.show();
                      sessionModel
                          .authorizeViaEmail(emailController.value.text)
                          .then((result) {
                        context.loaderOverlay.hide();
                        Navigator.pushNamed(
                            context, routeAuthorizeDeviceViaEmailPin);
                      }).onError((error, stackTrace) {
                        context.loaderOverlay.hide();
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
