import 'package:auto_route/auto_route.dart';
import 'package:lantern/core/router/router.gr.dart';
import 'package:lantern/messaging/messaging_model.dart';
import 'package:lantern/messaging/widgets/contacts/generate_grouped_list.dart';
import 'package:lantern/messaging/widgets/message_utils.dart';
import 'package:lantern/model/model.dart';
import 'package:lantern/model/protos_flutteronly/messaging.pb.dart';
import 'package:lantern/package_store.dart';
import 'package:lantern/ui/widgets/button.dart';
import 'package:lantern/utils/iterable_extension.dart';

class Introduce extends StatefulWidget {
  @override
  _IntroduceState createState() => _IntroduceState();
}

class _IntroduceState extends State<Introduce> {
  var selectedContacts = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<MessagingModel>();
    return BaseScreen(
      title: 'Introduce Contacts (${selectedContacts.length})'.i18n,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Text(
              'Select two or more contacts to introduce.  They will be sent invitations to start messaging each other. '
                  .i18n,
              style: tsBaseScreenBodyText),
        ),
        Expanded(
          child: model.contacts(builder: (context,
              Iterable<PathAndValue<Contact>> _contacts, Widget? child) {
            // TODO (Connect Friends PR) this should not be _contacts but [contactRequestees]
            var sortedContacts = _contacts.toList()
              ..sort((a, b) => sanitizeContactName(a.value)
                  .toLowerCase()
                  .toString()
                  .compareTo(
                      sanitizeContactName(b.value).toLowerCase().toString()));

            var groupedSortedContacts = sortedContacts.groupBy(
                (el) => sanitizeContactName(el.value)[0].toLowerCase());

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: groupedContactListGenerator(
                      groupedSortedList: groupedSortedContacts,
                      leadingCallback: (Contact contact) => CircleAvatar(
                            backgroundColor: avatarBgColors[
                                generateUniqueColorIndex(contact.contactId.id)],
                            child: Text(
                                sanitizeContactName(contact)
                                    .substring(0, 2)
                                    .toUpperCase(),
                                style: const TextStyle(color: Colors.white)),
                          ),
                      trailingCallback: (int index) => Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(
                                getCheckboxColor),
                            value: false,
                            shape: const CircleBorder(side: BorderSide.none),
                            onChanged: (bool? value) => setState(() {
                              // TODO: handle saving selected status
                            }),
                          )),
                ),
                // TODO (Connect Friends) create method for identifying True in selectedContacts map
                if (selectedContacts.isNotEmpty)
                  Expanded(
                    child: Container(
                      color: grey1,
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Button(
                              width: 200,
                              text: 'Send Invitations'.i18n.toUpperCase(),
                              onPressed: () async {
                                // TODO (Connect Friends) add model.SendReqs()
                                showSnackbar(
                                    context, 'Introductions Sent!'.i18n);
                                await Future.delayed(
                                  const Duration(milliseconds: 1000),
                                  () async => await context.router.pop(),
                                );
                              },
                            ),
                          ]),
                    ),
                  )
              ],
            );
          }),
        )
      ]),
    );
  }
}
