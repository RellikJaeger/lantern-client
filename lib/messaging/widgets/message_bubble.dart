import 'package:lantern/model/model.dart';
import 'package:lantern/model/protos_flutteronly/messaging.pb.dart';
import 'package:lantern/package_store.dart';
import 'package:lantern/utils/humanize.dart';
import 'package:flutter/services.dart';

import 'reactions.dart';
import '../messaging_model.dart';
import 'attachment.dart';

class MessageBubble extends StatelessWidget {
  final PathAndValue<StoredMessage> message;
  final StoredMessage? priorMessage;
  final StoredMessage? nextMessage;
  final Contact contact;

  MessageBubble(this.message, this.priorMessage, this.nextMessage, this.contact)
      : super();

  @override
  Widget build(BuildContext context) {
    var model = context.watch<MessagingModel>();

    return model.message(context, message,
        (BuildContext context, StoredMessage msg, Widget? child) {
      if (msg.firstViewedAt == 0) {
        model.markViewed(message);
      }

      var outbound = msg.direction == MessageDirection.OUT;
      var inbound = !outbound;

      var statusRow = Row(mainAxisSize: MainAxisSize.min, children: []);

      // construct a more convenient to parse Map<String, List<string>>
      // matching reactorId to DisplayName has been taken care of
      // example (key-value): ['😢', ['DisplayName1', 'DisplayName2']]
      var reactions = constructReactionsMap(msg, contact);

      reactions.forEach((key, value) {
        // only render this if the list of [reactorIds] is not empty
        if (value.isNotEmpty) {
          statusRow.children.add(Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                  // Tap on emoji to bring modal with breakdown of interactions
                  onTap: () =>
                      _displayEmojiBreakdownPopup(context, msg, reactions),
                  child: _displayEmojiCount(reactions, key))));
        }
      });
      statusRow.children.add(Opacity(
        opacity: 0.5,
        child: Text(
          message.value.ts.toInt().humanizeDate(),
          style: TextStyle(
            color: outbound ? Colors.white : Colors.black,
            fontSize: 12,
          ),
        ),
      ));

      var innerColumn = Column(
          crossAxisAlignment:
              outbound ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              if (msg.text.isNotEmpty)
                Flexible(
                  child: Text(
                    '${msg.text}',
                    style: TextStyle(
                      color: outbound ? Colors.white : Colors.black,
                    ),
                  ),
                ),
            ]),
          ]);

      // Render attachments
      innerColumn.children.addAll(msg.attachments.values
          .map((attachment) => attachmentWidget(attachment)));
      innerColumn.children.add(statusRow);

      var statusIcon = inbound
          ? null
          : msg.status == StoredMessage_DeliveryStatus.SENDING
              ? Icons.pending_outlined
              : msg.status == StoredMessage_DeliveryStatus.COMPLETELY_FAILED ||
                      msg.status ==
                          StoredMessage_DeliveryStatus.PARTIALLY_FAILED
                  ? Icons.error_outline
                  : null;
      if (statusIcon != null) {
        statusRow.children
            .add(Transform.scale(scale: .5, child: Icon(statusIcon)));
      }
      var startOfBlock = priorMessage == null ||
          priorMessage!.direction != message.value.direction;
      var endOfBlock = nextMessage == null ||
          nextMessage!.direction != message.value.direction;
      var newestMessage = nextMessage == null;
      return InkWell(
        onLongPress: () {
          _buildActionsPopup(outbound, context, msg, model, reactions);
        },
        child: _buildRow(outbound, inbound, startOfBlock, endOfBlock,
            newestMessage, innerColumn),
      );
    });
  }

  Container _displayEmojiCount(
      Map<String, List<dynamic>> reactions, String emoticon) {
    // identify which Map (key-value) pair corresponds to the emoticton at hand
    final currentReactionKey =
        reactions.keys.firstWhere((key) => key == emoticon);
    final reactorsToKey = reactions[currentReactionKey]!;
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

  Future<void> _displayEmojiBreakdownPopup(BuildContext context,
      StoredMessage msg, Map<String, List<dynamic>> reactions) {
    return showModalBottomSheet(
        context: context,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
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

  Widget _buildRow(bool outbound, bool inbound, bool startOfBlock,
      bool endOfBlock, bool newestMessage, Column innerColumn) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          outbound ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
                left: outbound ? 20 : 4,
                right: outbound ? 4 : 20,
                top: 4,
                bottom: 4),
            child: _buildBubbleUI(outbound, inbound, startOfBlock, endOfBlock,
                newestMessage, innerColumn),
          ),
        ),
      ],
    );
  }

  Future _buildActionsPopup(
      bool outbound,
      BuildContext context,
      StoredMessage msg,
      MessagingModel model,
      Map<String, List<dynamic>> reactions) {
    var reactionOptions = reactions.keys.toList();
    return showModalBottomSheet(
        context: context,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        builder: (context) {
          return Wrap(children: [
            if (!outbound)
              const Padding(
                padding: EdgeInsets.all(8),
              ),
            // Other users' messages
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: reactionOptions
                  .map((e) => Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color:
                              Colors.grey.shade200, // TODO generalize in theme
                          borderRadius:
                              const BorderRadius.all(Radius.circular(999)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: InkWell(
                            onTap: () {
                              model.react(message, e);
                              Navigator.pop(context);
                            },
                            child: Transform.scale(
                                scale: 1.2,
                                child: Text(e,
                                    style: const TextStyle(fontSize: 16))),
                          ),
                        ),
                      ))
                  .toList(growable: false),
            ),
            if (!outbound)
              const Padding(
                  padding: EdgeInsets.only(top: 8), child: Divider(height: 3)),
            ListTile(
              leading: const Icon(Icons.reply),
              title: Text('Reply'.i18n),
              onTap: () {},
            ),
            _CopiedTextWidget(message),
            ListTile(
              leading: const Icon(Icons.delete),
              title: Text('Delete for me'.i18n),
              onTap: () => _showDeleteDialog(context, model, true),
            ),
            // User's own messages
            if (outbound)
              ListTile(
                leading: const Icon(Icons.delete_forever),
                title: Text('Delete for everyone'.i18n),
                onTap: () => _showDeleteDialog(context, model, false),
              ),
          ]);
        });
  }

  Future<void> _showDeleteDialog(context, model, isLocal) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isLocal
              ? const Text('Delete for me')
              : const Text('Delete for everyone'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                isLocal
                    ? const Text(
                        'This will delete the message for you only. Everyone else will still be able to see it.')
                    : const Text(
                        'This will delete the message for everyone.'), // TODO: i18n
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                isLocal
                    ? model.deleteLocally(message)
                    : model.deleteGlobally(message);
                Navigator.of(context)
                    .pop(); // TODO: close showModalBottomSheet as well
              },
              child: const Text('Delete'),
            )
          ],
        );
      },
    );
  }

  Widget _buildBubbleUI(bool outbound, bool inbound, bool startOfBlock,
      bool endOfBlock, bool newestMessage, Column innerColumn) {
    return Container(
      decoration: BoxDecoration(
        color: outbound ? Colors.black38 : Colors.black12,
        borderRadius: BorderRadius.only(
          topLeft:
              inbound && !startOfBlock ? Radius.zero : const Radius.circular(5),
          topRight: outbound && !startOfBlock
              ? Radius.zero
              : const Radius.circular(5),
          bottomRight: outbound && (!endOfBlock || newestMessage)
              ? Radius.zero
              : const Radius.circular(5),
          bottomLeft: inbound && (!endOfBlock || newestMessage)
              ? Radius.zero
              : const Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
        child: innerColumn,
      ),
    );
  }
}

class _CopiedTextWidget extends StatefulWidget {
  final PathAndValue<StoredMessage> _message;

  _CopiedTextWidget(this._message);

  @override
  State<StatefulWidget> createState() {
    return _CopiedTextWidgetState();
  }
}

class _CopiedTextWidgetState extends State<_CopiedTextWidget> {
  var _copied = false;

  void _onPointerDown(_) {
    setState(() {
      _copied = true;
    });
    Clipboard.setData(ClipboardData(text: widget._message.value.text));
  }

  void _onPointerUp(_) async {
    await Future.delayed(
        const Duration(milliseconds: 600), () => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerUp: _onPointerUp,
        onPointerDown: _onPointerDown,
        child: ListTile(
          leading: _copied ? const Icon(Icons.check) : const Icon(Icons.copy),
          title: Text('Copy Text'.i18n),
        ));
  }
}
