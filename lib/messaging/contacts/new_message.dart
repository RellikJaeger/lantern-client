import 'package:lantern/messaging/contacts/add_contact_QR.dart';
import 'package:lantern/messaging/contacts/grouped_contact_list.dart';
import 'package:lantern/messaging/messaging.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var scrollListController = ItemScrollController();
  Contact? _updatedContact;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<MessagingModel>();

    return BaseScreen(
      title: 'new_message'.i18n,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'search'.i18n,
          onPressed: () {},
        ),
      ],
      body: model.me(
        (BuildContext context, Contact me, Widget? child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.qr_code,
                  color: black,
                ),
                title: CText('scan_qr_code'.i18n, style: tsBody3),
                trailing: const CAssetImage(
                  path: ImagePaths.keyboard_arrow_right_icon,
                  size: 24,
                ),
                onTap: () async => await context.router
                    .push(
                  FullScreenDialogPage(widget: AddViaQR(me: me)),
                )
                    .then((value) {
                  // we only care about this if it comes back with an updated contact
                  if (value != null) {
                    setState(() {
                      _updatedContact = value as Contact;
                    });
                    showSnackbar(
                        context: context,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CText(
                                'qr_success_snackbar'
                                    .i18n
                                    .fill([_updatedContact!.displayName]),
                                overflow: TextOverflow.visible,
                                style: tsBodyColor(white),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 4000),
                        action: SnackBarAction(
                          textColor: secondaryPink,
                          label: 'start_chat'.i18n.toUpperCase(),
                          onPressed: () async {
                            await context.pushRoute(Conversation(
                                contactId: _updatedContact!.contactId));
                          },
                        ));
                  }
                }),
              ),
              Divider(thickness: 1, color: grey2),
              ListTile(
                leading: Icon(
                  Icons.people,
                  color: black,
                ),
                title: CText('introduce_contacts'.i18n, style: tsBody3),
                trailing: const CAssetImage(
                  path: ImagePaths.keyboard_arrow_right_icon,
                  size: 24,
                ),
                onTap: () async => await context.pushRoute(const Introduce()),
              ),
              Divider(thickness: 1, color: grey2),
              Container(
                child: model.contacts(builder: (context,
                    Iterable<PathAndValue<Contact>> _contacts, Widget? child) {
                  return _contacts.toList().isNotEmpty
                      ? ListTile(
                          title: CText('contacts'.i18n.toUpperCase(),
                              style: tsBody3))
                      : Container();
                }),
              ),
              Flexible(child: model.contacts(builder: (context,
                  Iterable<PathAndValue<Contact>> _contacts, Widget? child) {
                var contacts = _contacts.toList();

                // related https://github.com/getlantern/android-lantern/issues/299
                var sortedContacts = contacts.sortedAlphabetically();

                var groupedSortedContacts = sortedContacts.groupBy((el) =>
                    sanitizeContactName(el.value.displayName[0].toLowerCase()));

                // scroll to index of the contact we just added, if there is one
                // otherwise start from top (index = 0)
                var scrollIndex = _updatedContact != null
                    ? sortedContacts.indexWhere((element) =>
                        element.value.contactId.id ==
                        _updatedContact!.contactId.id)
                    : 0;
                if (scrollListController.isAttached) {
                  scrollListController.scrollTo(
                      index: scrollIndex != -1 ? scrollIndex : 0,
                      //if recent contact can not be found in our list for some reason
                      duration: const Duration(milliseconds: 300));
                }

                return groupedSortedContacts.isNotEmpty
                    ? groupedContactListGenerator(
                        groupedSortedList: groupedSortedContacts,
                        scrollListController: scrollListController,
                        leadingCallback: (Contact contact) => CustomAvatar(
                            id: contact.contactId.id,
                            displayName: contact.displayName),
                        onTapCallback: (Contact contact) async =>
                            await context.pushRoute(
                                Conversation(contactId: contact.contactId)))
                    : Container(
                        alignment: AlignmentDirectional.center,
                        padding: const EdgeInsetsDirectional.all(16.0),
                        child: CText('no_contacts_yet'.i18n,
                            textAlign: TextAlign.center,
                            style:
                                tsBody3)); // rendering this instead of SizedBox() to avoid null dimension errors
              })),
            ],
          );
        },
      ),
    );
  }
}
