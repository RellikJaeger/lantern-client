import 'package:lantern/messaging/messaging.dart';

SizedBox renderLongTapMenu(
        {required Contact contact, required BuildContext context}) =>
    SizedBox(
      height: contact.isMe ? 48 : 48 * 2,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListItemFactory.focusMenuItem(
                icon: ImagePaths.user,
                content: 'view_contact_info'.i18n,
                onTap: () async {
                  await context.router.pop();
                  await context.pushRoute(ContactInfo(
                      model:
                          Provider.of<MessagingModel>(context, listen: false),
                      contact: contact));
                }),
            if (!contact.isMe)
              ListItemFactory.focusMenuItem(
                icon: ImagePaths.people,
                content: 'introduce_contact'.i18n,
                onTap: () async {
                  await context.router.pop();
                  await context.pushRoute(
                      Introduce(singleIntro: true, contactToIntro: contact));
                },
              ),
          ],
        ),
      ),
    );
