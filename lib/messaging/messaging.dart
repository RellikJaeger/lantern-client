import 'package:lantern/package_store.dart';

import 'messages.dart';

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
    return Messages();
  }

  @override
  bool get wantKeepAlive => true;
}
