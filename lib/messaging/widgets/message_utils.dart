import 'package:lantern/model/protos_flutteronly/messaging.pb.dart';
import 'package:lantern/package_store.dart';
import 'package:lantern/utils/humanize.dart';

Map<String, List<dynamic>> constructReactionsMap(
    StoredMessage msg, Contact contact) {
  // hardcode the list of available emoticons in a way that is convenient to parse
  var reactions = {
    '👍': [],
    '👎': [],
    '😄': [],
    '❤': [],
    '😢': [], // TODO: Add the [...] option here
  };
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

String matchIdToDisplayName(String replyToSenderId, Contact contact) {
  return replyToSenderId == contact.contactId.id
      ? contact.displayName
      : 'me'; // TODO: i18n
}

String? getMessageTextById(String replyToId, StoredMessage? quotedMessage) {
  return quotedMessage?.id == replyToId ? quotedMessage?.text : '';
}

IconData? getStatusIcon(bool inbound, StoredMessage msg) {
  return inbound
      ? null
      : msg.status == StoredMessage_DeliveryStatus.COMPLETELY_SENT
          ? Icons.check_circle_outline_outlined
          : msg.status == StoredMessage_DeliveryStatus.SENDING
              ? Icons.pending_outlined
              : msg.status == StoredMessage_DeliveryStatus.COMPLETELY_FAILED ||
                      msg.status ==
                          StoredMessage_DeliveryStatus.PARTIALLY_FAILED
                  ? Icons.error_outline
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
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // TODO generalize in theme
        borderRadius: const BorderRadius.all(Radius.circular(999)),
      ),
      child: Padding(
          padding: reactorsToKey.length > 1
              ? const EdgeInsets.only(left: 3, top: 3, right: 6, bottom: 3)
              : const EdgeInsets.all(3),
          child: reactorsToKey.length > 1
              ? Text(emoticon + reactorsToKey.length.toString())
              : Text(emoticon)));
}

String? determineDateSwitch(
    StoredMessage? priorMessage, StoredMessage? nextMessage) {
  if (priorMessage == null || nextMessage == null) return null;

  var currentDateTime = priorMessage.ts.toInt().humanizeDateSwitch();
  final nextMessageDateTime = nextMessage.ts.toInt().humanizeDateSwitch();

  if (currentDateTime != nextMessageDateTime) {
    currentDateTime = nextMessageDateTime;
    return currentDateTime;
  }

  return null;
}
