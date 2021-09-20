import 'package:lantern/messaging/messaging.dart';

class ReplySnippetHeader extends StatelessWidget {
  const ReplySnippetHeader({
    Key? key,
    required this.msg,
    required this.contact,
  }) : super(key: key);

  final StoredMessage msg;
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Icon(
          Icons.reply,
          size: 12,
        ),
        CText(
          'Replying to ${matchIdToDisplayName(msg.replyToSenderId, contact)}',
          overflow: TextOverflow.ellipsis,
          style: tsSubtitle2,
        ),
      ],
    );
  }
}
