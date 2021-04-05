import 'package:lantern/model/messaging_model.dart';
import 'package:lantern/model/model.dart';
import 'package:lantern/model/protos_flutteronly/messaging.pb.dart';
import 'package:lantern/package_store.dart';

class Conversations extends StatefulWidget {
  @override
  _ConversationsState createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  MessagingModel model;

  @override
  Widget build(BuildContext context) {
    model = context.watch<MessagingModel>();

    return BaseScreen(
        title: 'Messages'.i18n,
        actions: [
          IconButton(
              icon: Icon(Icons.qr_code),
              tooltip: "Your Contact Info".i18n,
              onPressed: () {
                Navigator.restorablePushNamed(context, 'your_contact_info');
              }),
        ],
        body: model.contactsByActivity(builder:
            (context, Iterable<PathAndValue<Contact>> _contacts, Widget child) {
          // TODO: implement filtering, but include contacts that have sent attachments without text
          // var contacts = _contacts.where((contact) => contact.value.mostRecentMessageText?.isNotEmpty).toList();
          var contacts = _contacts.toList();
          contacts.sort((a, b) {
            return (b.value.mostRecentMessageTs - a.value.mostRecentMessageTs)
                .toInt();
          });
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              var contact = contacts[index];
              return model.contact(context, contact,
                  (BuildContext context, Contact contact, Widget child) {
                return ListTile(
                  title: Text(
                      contact.displayName != null && contact.displayName.isEmpty
                          ? 'Unnamed'.i18n
                          : contact.displayName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      "${contact.mostRecentMessageDirection == MessageDirection.OUT ? 'Me'.i18n + ': ' : ''}${contact.mostRecentMessageText}",
                      overflow: TextOverflow.ellipsis),
                  onTap: () async {
                    Navigator.pushNamed(context, 'conversation',
                        arguments: contact);
                  },
                );
              });
            },
          );
        }),
        actionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.restorablePushNamed(context, 'new_message');
          },
        ));
  }
}
