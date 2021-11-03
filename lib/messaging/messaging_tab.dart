import 'chats.dart';
import 'messaging.dart';

class MessagesTab extends StatefulWidget {
  MessagesTab();

  @override
  _MessagesTabState createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Chats();
  }

  @override
  bool get wantKeepAlive => true;
}
