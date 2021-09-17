import 'package:intl/intl.dart';

import 'messaging.dart';

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

List<dynamic> constructReactionsList(BuildContext context,
    Map<String, List<dynamic>> reactions, StoredMessage msg) {
  var reactionsList = [];
  reactions.forEach(
    (key, value) {
      if (value.isNotEmpty) {
        reactionsList.add(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // Tap on emoji to bring modal with breakdown of interactions
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => displayEmojiBreakdownPopup(context, msg, reactions),
              child: displayEmojiCount(reactions, key),
            ),
          ),
        );
      }
    },
  );
  return reactionsList;
}

String matchIdToDisplayName(String contactIdToMatch, Contact contact) {
  return contactIdToMatch == contact.contactId.id
      ? contact.displayName
      : 'me'.i18n;
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
                  width: 8,
                  height: 8,
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
              Center(
                  child: CText('Reactions',
                      style: CTextStyle(fontSize: 18.0, lineHeight: 25))),
              CDivider(
                thickness: 1,
                color: grey2,
                margin: 0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var reaction in reactions.entries)
                    if (reaction.value.isNotEmpty)
                      ListTile(
                        leading: CText(reaction.key, style: tsBody),
                        title: CText(reaction.value.join(', '), style: tsBody),
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
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(999)),
      ),
      child: Padding(
          padding: reactorsToKey.length > 1
              ? const EdgeInsets.only(left: 3, top: 3, right: 6, bottom: 3)
              : const EdgeInsets.all(3),
          child: reactorsToKey.length > 1
              ? CText(emoticon + reactorsToKey.length.toString(),
                  style: CTextStyle(fontSize: 12, lineHeight: 16))
              : CText(emoticon,
                  style: CTextStyle(fontSize: 12, lineHeight: 16))));
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

void showSnackbar(
    {required BuildContext context,
    required Widget content,
    Duration duration = const Duration(milliseconds: 1000),
    SnackBarAction? action}) {
  final snackBar = SnackBar(
    content: content,
    action: action,
    backgroundColor: black,
    duration: duration,
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    behavior: SnackBarBehavior.floating,
    elevation: 1,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Widget fullScreenDialogLayout(
    {required Color topColor,
    required Color iconColor,
    required BuildContext context,
    required Widget title,
    Widget? backButton,
    Function? onBackCallback,
    required Function onCloseCallback,
    required Widget child}) {
  return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            color: topColor,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (backButton != null)
                  Container(
                    padding: const EdgeInsetsDirectional.only(top: 25),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: backButton,
                      onPressed: () => onBackCallback!(),
                    ),
                  ),
                Container(
                  padding: const EdgeInsetsDirectional.only(top: 25),
                  alignment: Alignment.center,
                  child: title,
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(top: 25),
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: iconColor,
                    ),
                    onPressed: () => onCloseCallback(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: child)
        ],
      ));
}

Future<void> displayConversationOptions(
    MessagingModel model, BuildContext parentContext, Contact contact) {
  return showModalBottomSheet(
      context: parentContext,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      builder: (bottomContext) => Wrap(
            alignment: WrapAlignment.center,
            children: [
              ListTile(
                leading: const CAssetImage(
                  path: ImagePaths.disappearing_timer_icon,
                  size: 24,
                ),
                contentPadding: const EdgeInsetsDirectional.only(
                    top: 7, bottom: 5, start: 16, end: 16),
                title: Transform.translate(
                  offset: const Offset(-14, 0),
                  child: CText('disappearing_messages'.i18n,
                      style: tsBottomModalListItem),
                ),
                onTap: () async {
                  final scrollController = ScrollController();
                  final seconds = <int>[
                    5,
                    60,
                    3600,
                    10800,
                    21600,
                    86400,
                    604800,
                    0
                  ];
                  var selectedPosition = -1;

                  return showDialog(
                    context: bottomContext,
                    barrierDismissible: true,
                    barrierColor: black.withOpacity(0.8),
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        contentPadding: const EdgeInsetsDirectional.all(0),
                        clipBehavior: Clip.hardEdge,
                        content: ConstrainedBox(
                          constraints: disappearingDialogConstraints(context),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsetsDirectional.only(top: 16.0),
                                color: white,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    CText(
                                      'disappearing_messages'.i18n,
                                      style: tsBody3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 16.0,
                                          end: 16.0,
                                          top: 24.0,
                                          bottom: 24.0),
                                      child:
                                          contact.messagesDisappearAfterSeconds ==
                                                      0 ||
                                                  (selectedPosition != -1 &&
                                                      seconds[selectedPosition] ==
                                                          0)
                                              ? CTextWrap(
                                                  'message_disappearing'.i18n,
                                                  style: tsBodyGrey,
                                                )
                                              : CTextWrap(
                                                  'message_disappearing_description'
                                                      .i18n
                                                      .fill([
                                                    selectedPosition != -1
                                                        ? seconds[
                                                                selectedPosition]
                                                            .humanizeSeconds(
                                                                longForm: true)
                                                        : contact
                                                            .messagesDisappearAfterSeconds
                                                            .humanizeSeconds(
                                                                longForm: true)
                                                  ]),
                                                  style: tsBodyGrey,
                                                ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              CDivider(
                                thickness: 1,
                                color: grey3,
                                size: 2,
                                margin: 16,
                              ),
                              Flexible(
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    // set the height so that one of the rows
                                    // gets cut in half, to help give the user a
                                    // visual cue that they can scroll
                                    final maxHeight =
                                        constraints.maxHeight / 48 * 48 - 24;
                                    return ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: maxHeight,
                                      ),
                                      child: Scrollbar(
                                        controller: scrollController,
                                        interactive: true,
                                        isAlwaysShown: true,
                                        showTrackOnHover: true,
                                        radius: const Radius.circular(50),
                                        child: ListView.builder(
                                          controller: scrollController,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics: defaultScrollPhysics,
                                          itemCount: seconds.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .only(),
                                              horizontalTitleGap: 8,
                                              minLeadingWidth: 20,
                                              onTap: () async {
                                                setState(() {
                                                  selectedPosition = index;
                                                });
                                              },
                                              selectedTileColor: Colors.white,
                                              tileColor: const Color.fromRGBO(
                                                  245, 245, 245, 1),
                                              selected: selectedPosition != -1
                                                  ? seconds[index] !=
                                                      seconds[selectedPosition]
                                                  : contact
                                                          .messagesDisappearAfterSeconds !=
                                                      seconds[index],
                                              leading: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(start: 8),
                                                child: Transform.scale(
                                                  scale: 1.2,
                                                  child: Radio(
                                                    value: selectedPosition !=
                                                            -1
                                                        ? seconds[index] !=
                                                            seconds[
                                                                selectedPosition]
                                                        : contact
                                                                .messagesDisappearAfterSeconds !=
                                                            seconds[index],
                                                    groupValue: false,
                                                    fillColor:
                                                        MaterialStateProperty
                                                            .resolveWith<Color>(
                                                      (states) =>
                                                          states.contains(
                                                                  MaterialState
                                                                      .selected)
                                                              ? primaryPink
                                                              : black,
                                                    ),
                                                    activeColor: primaryPink,
                                                    onChanged: (value) async {
                                                      setState(() {
                                                        selectedPosition =
                                                            index;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              title: Transform.translate(
                                                offset: const Offset(-4, 0),
                                                child: CText(
                                                  seconds[index] == 0
                                                      ? 'off'.i18n
                                                      : seconds[index]
                                                          .humanizeSeconds(
                                                              longForm: true),
                                                  style: tsBody,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    const CDivider(
                                      thickness: 1,
                                      color: Color.fromRGBO(235, 235, 235, 1),
                                      size: 1,
                                      margin: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsetsDirectional
                                                        .only(
                                                    top: 16,
                                                    bottom: 16,
                                                    end: 16)),
                                          ),
                                          onPressed: () async =>
                                              context.router.pop(),
                                          child: CText(
                                              'cancel'.i18n.toUpperCase(),
                                              style: tsButtonGrey),
                                        ),
                                        TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsetsDirectional
                                                        .only(
                                                    top: 16,
                                                    bottom: 16,
                                                    end: 24)),
                                          ),
                                          onPressed: () async {
                                            if (selectedPosition != -1) {
                                              await model.setDisappearSettings(
                                                  contact,
                                                  seconds[selectedPosition]);
                                            }
                                            await context.router.pop();
                                            await parentContext.router.pop();
                                          },
                                          child: CText('set'.i18n.toUpperCase(),
                                              style: tsButtonPink),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const CDivider(
                  size: 1,
                  thickness: 1,
                  margin: 0,
                  color: Color.fromRGBO(235, 235, 235, 1)),
              ListTile(
                leading: const CAssetImage(
                  path: ImagePaths.introduce_contact_icon,
                  size: 16,
                ),
                contentPadding: const EdgeInsetsDirectional.only(
                    top: 5, bottom: 5, start: 16, end: 16),
                title: Transform.translate(
                    offset: const Offset(-14, 0),
                    child: CText('introduce_contacts'.i18n,
                        style: tsBottomModalListItem)),
                onTap: () async =>
                    await bottomContext.pushRoute(const Introduce()),
              ),
              const CDivider(
                  size: 1,
                  thickness: 1,
                  margin: 0,
                  color: Color.fromRGBO(235, 235, 235, 1)),
              ListTile(
                  leading: const CAssetImage(
                    path: ImagePaths.trash_icon,
                    size: 24,
                  ),
                  contentPadding: const EdgeInsetsDirectional.only(
                      top: 5, bottom: 5, start: 16, end: 16),
                  title: Transform.translate(
                    offset: const Offset(-14, 0),
                    child: TextOneLine(
                        'delete_contact_name'.i18n.fill([contact.displayName]),
                        style: tsBottomModalListItem),
                  ),
                  onTap: () => showDialog<void>(
                        context: bottomContext,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.delete),
                                ),
                                CText('delete_contact'.i18n.toUpperCase(),
                                    style: tsBody3),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  CTextWrap('delete_contact_confirmation'.i18n,
                                      style: tsBody)
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () async => context.router.pop(),
                                    child: CText('cancel'.i18n.toUpperCase(),
                                        style: tsButtonGrey),
                                  ),
                                  const SizedBox(width: 15),
                                  TextButton(
                                    onPressed: () async {
                                      context.loaderOverlay.show(
                                          widget: Center(
                                        child: CircularProgressIndicator(
                                          color: white,
                                        ),
                                      ));
                                      try {
                                        await model.deleteDirectContact(
                                            contact.contactId.id);
                                      } catch (e, s) {
                                        showErrorDialog(context,
                                            e: e,
                                            s: s,
                                            des: 'error_delete_contact'.i18n);
                                      } finally {
                                        context.loaderOverlay.hide();
                                        // In order to be capable to return to the root screen, we need to pop the bottom sheet
                                        // and then pop the root screen.
                                        context.router.popUntilRoot();
                                        parentContext.router.popUntilRoot();
                                      }
                                    },
                                    child: CText(
                                        'delete_contact'.i18n.toUpperCase(),
                                        style: tsButtonPink),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      )),
            ],
          ));
}

BoxConstraints disappearingDialogConstraints(BuildContext context) {
  var size = MediaQuery.of(context).size;
  // limit the width of the dialog on really wide screens
  var width = min(size.width * 0.9, 304.0);

  // note - minWidth and maxWidth have to equal to avoid layout errors on wide
  // screens.
  return BoxConstraints(
    maxHeight: size.height * 0.9,
    minWidth: width,
    maxWidth: width,
  );
}

ScrollPhysics get defaultScrollPhysics => const BouncingScrollPhysics();
