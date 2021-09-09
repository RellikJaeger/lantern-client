import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:lantern/core/router/router.gr.dart';
import 'package:lantern/messaging/calling/call.dart';
import 'package:lantern/messaging/messaging_model.dart';
import 'package:lantern/model/protos_flutteronly/messaging.pb.dart';
import 'package:lantern/package_store.dart';
import 'package:lantern/ui/widgets/custom_asset_image.dart';

class CallAction extends StatelessWidget {
  final Contact contact;

  CallAction(this.contact) : super();

  @override
  Widget build(BuildContext context) {
    var model = context.watch<MessagingModel>();

    return model.singleContact(
      context,
      contact,
      (context, contact, child) => IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0))),
            builder: (context) => Wrap(
              children: [
                ListTile(
                  leading: const CustomAssetImage(
                    path: ImagePaths.phone_icon,
                  ),
                  title: Text('call'.i18n),
                  onTap: () async {
                    Navigator.pop(context);
                    await context.pushRoute(
                      FullScreenDialogPage(
                          widget: Call(contact: contact, model: model)),
                    );
                  },
                ),
                ListTile(
                  leading: const CustomAssetImage(path: ImagePaths.cancel_icon),
                  title: Text('cancel'.i18n),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
        icon: const CustomAssetImage(
          path: ImagePaths.phone_icon,
          size: 16.0,
        ),
      ),
    );
  }
}
