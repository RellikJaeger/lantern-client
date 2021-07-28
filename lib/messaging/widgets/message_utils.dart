import 'package:lantern/model/protos_flutteronly/messaging.pb.dart';
import 'package:lantern/package_store.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

Map<String, List<dynamic>> constructReactionsMap(
    StoredMessage msg, Contact contact) {
  // hardcode the list of available emoticons in a way that is convenient to parse
  var reactions = {'👍': [], '👎': [], '😄': [], '❤': [], '😢': [], '•••': []};
  // https://api.dart.dev/stable/2.12.4/dart-core/Map/Map.fromIterables.html
  // create a Map from Iterable<String> and Iterable<Reaction>
  var reactor_emoticon_map = {};
  Map.fromIterables(msg.reactions.keys, msg.reactions.values)
      // reactorID <---> emoticon to reactor_emoticon_map
      .forEach((reactorId, reaction) =>
          reactor_emoticon_map[reactorId] = reaction.emoticon);

  // swap key-value pairs to create emoticon <--> List<reactorId>
  reactor_emoticon_map.forEach((reactorId, reaction) {
    reactions[reaction] = [...?reactions[reaction], reactorId];
  });

  // humanize reactorIdList
  reactions.forEach((reaction, reactorIdList) =>
      reactions[reaction] = _humanizeReactorIdList(reactorIdList, contact));

  return reactions;
}

List<dynamic> _humanizeReactorIdList(
    List<dynamic> reactorIdList, Contact contact) {
  var humanizedList = [];
  if (reactorIdList.isEmpty) return humanizedList;

  reactorIdList.forEach((reactorId) =>
      humanizedList.add(matchIdToDisplayName(reactorId, contact)));
  return humanizedList;
}

String matchIdToDisplayName(String contactIdToMatch, Contact contact) {
  final interlocutor =
      contactIdToMatch == contact.contactId.id ? contact.displayName : 'me';
  return 'Replying to $interlocutor';
}

Widget? renderStatusIcon(bool inbound, bool outbound, StoredMessage msg) {
  return inbound
      ? null
      : msg.status == StoredMessage_DeliveryStatus.COMPLETELY_SENT
          ? Icon(
              Icons.check_circle_outline_outlined,
              size: 12,
              color: outbound ? outboundMsgColor : inboundMsgColor,
            )
          : msg.status == StoredMessage_DeliveryStatus.SENDING
              ? SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 0.5,
                    color: outbound ? outboundMsgColor : inboundMsgColor,
                  ),
                )
              : msg.status == StoredMessage_DeliveryStatus.COMPLETELY_FAILED ||
                      msg.status ==
                          StoredMessage_DeliveryStatus.PARTIALLY_FAILED
                  ? Icon(
                      Icons.error_outline,
                      size: 12,
                      color: outbound ? outboundMsgColor : inboundMsgColor,
                    )
                  : null;
}

Future<void> displayEmojiBreakdownPopup(BuildContext context, StoredMessage msg,
    Map<String, List<dynamic>> reactions) {
  return showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
      builder: (context) => Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
              ),
              const Center(
                  child: Text('Reactions', style: TextStyle(fontSize: 18.0))),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var reaction in reactions.entries)
                    if (reaction.value.isNotEmpty)
                      ListTile(
                        leading: Text(reaction.key),
                        title: Text(reaction.value.join(', ')),
                      ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(12),
              ),
            ],
          ));
}

Container displayEmojiCount(
    Map<String, List<dynamic>> reactions, String emoticon) {
  // identify which Map (key-value) pair corresponds to the displayed emoticon
  final reactionKey = reactions.keys.firstWhere((key) => key == emoticon);
  final reactorsToKey = reactions[reactionKey]!;
  return Container(
      decoration: const BoxDecoration(
        color: Colors.white, // TODO generalize in theme
        borderRadius: BorderRadius.all(Radius.circular(999)),
      ),
      child: Padding(
          padding: reactorsToKey.length > 1
              ? const EdgeInsets.only(left: 3, top: 3, right: 6, bottom: 3)
              : const EdgeInsets.all(3),
          child: reactorsToKey.length > 1
              ? Text(emoticon + reactorsToKey.length.toString(),
                  style: const TextStyle(fontSize: 12))
              : Text(emoticon, style: const TextStyle(fontSize: 12))));
}

String determineDateSwitch(
    StoredMessage? priorMessage, StoredMessage? nextMessage) {
  if (priorMessage == null || nextMessage == null) return '';

  var currentDateTime =
      DateTime.fromMillisecondsSinceEpoch(priorMessage.ts.toInt());
  var nextMessageDateTime =
      DateTime.fromMillisecondsSinceEpoch(nextMessage.ts.toInt());

  if (nextMessageDateTime.difference(currentDateTime).inDays >= 1) {
    currentDateTime = nextMessageDateTime;
    return DateFormat.yMMMMd('en_US').format(currentDateTime);
  }

  return '';
}

bool determineDeletionStatus(StoredMessage msg) {
  return msg.remotelyDeletedAt != 0; // is 0 if message hasn't been deleted
}

void showSnackbar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, color: Colors.white),
        Expanded(
            child: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.white),
          textAlign: TextAlign.center,
        )),
      ],
    ),
    backgroundColor: Colors.green,
    duration: const Duration(milliseconds: 700),
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
    behavior: SnackBarBehavior.floating,
    elevation: 1,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Widget fullScreenDialogLayout(Color bgColor, Color iconColor,
    BuildContext context, List<Widget> widgetList) {
  return Container(
    color: bgColor,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.all(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: iconColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          ...widgetList
        ]),
  );
}
