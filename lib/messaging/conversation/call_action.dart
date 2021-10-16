import 'package:lantern/common/common.dart';
import 'package:lantern/messaging/calls/call.dart';
import 'package:lantern/messaging/messaging.dart';

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
        onPressed: () => showBottomModal(
            context: context,
            title: CText(
                'call_contact'.i18n.fill([contact.displayNameOrFallback]),
                maxLines: 1,
                style: tsSubtitle1),
            children: [
              BottomModalItem(
                leading: const CAssetImage(path: ImagePaths.phone),
                label: 'call'.i18n,
                onTap: () async {
                  Navigator.pop(context);
                  await context.pushRoute(
                    FullScreenDialogPage(
                        widget: Call(contact: contact, model: model)),
                  );
                },
              ),
              BottomModalItem(
                leading: const CAssetImage(path: ImagePaths.cancel),
                label: 'cancel'.i18n,
                onTap: () => Navigator.pop(context),
              ),
            ]),
        padding: const EdgeInsetsDirectional.only(top: 8, bottom: 8, start: 8),
        icon: const CAssetImage(path: ImagePaths.phone),
      ),
    );
  }
}
