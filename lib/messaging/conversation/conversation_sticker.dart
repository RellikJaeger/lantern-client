import 'package:lantern/messaging/messaging.dart';

class ConversationSticker extends StatelessWidget {
  final Contact contact;
  final int messageCount;

  const ConversationSticker(this.contact, this.messageCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: calculateStickerHeight(context, messageCount),
      child: Column(
        children: [
          // ** Illustration ** //
          Container(
              padding: const EdgeInsetsDirectional.only(top: 20, bottom: 8),
              child: Stack(
                children: [
                  SvgPicture.asset(
                    ImagePaths.sticker_figure_background,
                  ),
                  SvgPicture.asset(
                    ImagePaths.sticker_figure_foreground,
                    color: getIllustrationColor(contact),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 8, bottom: 8),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              children: [
                CText(
                  'start_of_your_history'.i18n,
                  style: tsBody2.copiedWith(color: grey5),
                ),
                CText(
                  contact.displayNameOrFallback,
                  overflow: TextOverflow.visible,
                  style: tsBody2.copiedWith(color: grey5),
                ),
              ],
            ),
          ),
          // ** Message Retention ** //
          Container(
            padding: const EdgeInsetsDirectional.only(top: 8, bottom: 20),
            child: FittedBox(
              fit: BoxFit.none,
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: grey3),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(borderRadius))),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      contact.messagesDisappearAfterSeconds > 0
                          ? const CAssetImage(
                              path: ImagePaths.timer, color: Colors.black)
                          : const CAssetImage(
                              path: ImagePaths.lock_clock, color: Colors.black),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 16, top: 8, bottom: 8),
                            child: contact.messagesDisappearAfterSeconds > 0
                                ? CText(
                                    'banner_message_retention'.i18n.fill([
                                      contact.messagesDisappearAfterSeconds
                                          .humanizeSeconds(longForm: true)
                                    ]),
                                    style: tsBody2.copiedWith(color: grey5))
                                : CText('banner_messages_persist'.i18n,
                                    style: tsBody2.copiedWith(color: grey5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateStickerHeight(BuildContext context, int messageCount) {
    final conversationInnerHeight = MediaQuery.of(context).size.height -
        100.0 -
        100.0; // rough approximation for inner height - top bar height - message bar height
    final messageHeight =
        60.0; // rough approximation of how much space a message takes up, including paddings
    final minStickerHeight = 353.0;
    return max(minStickerHeight,
        conversationInnerHeight - ((messageCount - 1) * messageHeight));
  }
}
