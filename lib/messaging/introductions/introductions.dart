import 'package:lantern/core/router/router.gr.dart';
import 'package:lantern/messaging/messaging_model.dart';
import 'package:lantern/messaging/contacts/contact_list_item.dart';
import 'package:lantern/messaging/conversation/message_utils.dart';
import 'package:lantern/model/model.dart';
import 'package:lantern/model/protos_flutteronly/messaging.pb.dart';
import 'package:lantern/package_store.dart';
import 'package:lantern/common/custom_badge.dart';
import 'package:lantern/common/iterable_extension.dart';
import 'package:lantern/common/show_alert_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:lantern/messaging/conversation/stored_message_extension.dart';

class Introductions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = context.watch<MessagingModel>();

    return BaseScreen(
        title: 'introductions'.i18n,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Text('introductions_info'.i18n,
                    style: tsBaseScreenBodyText),
              ),
              Expanded(child: model.introductionsToContact(builder: (context,
                  Iterable<PathAndValue<StoredMessage>> introductionPaths,
                  Widget? child) {
                // group by the contactId of the user who made the introduction
                // these are pointers to StoredMessages, they won't listen to an update to the value of the StoredMessage itself
                final groupedIntroductionPaths =
                    introductionPaths.groupBy((intro) => intro.value.contactId);
                return ListView.builder(
                  itemCount: groupedIntroductionPaths.length,
                  itemBuilder: (context, index) {
                    var introductorContactId =
                        groupedIntroductionPaths.keys.elementAt(index);
                    var introductionsPerIntroductor =
                        groupedIntroductionPaths.values.elementAt(index);
                    // match the <ContactId> to the <Contact> of the user who made the introduction
                    return Container(
                      child: model.singleContactById(
                          context,
                          introductorContactId,
                          (context, introductor, child) => Column(children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 16.0, 0, 4.0),
                                      child: Text(
                                        'introduced'.i18n +
                                            ' ' +
                                            introductor.displayName
                                                .toUpperCase(),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 1.0, color: grey3),
                                ...introductionsPerIntroductor.map(
                                    // need to subscribe to StoredMessage via model.message() to receive updates about status
                                    (introMessage) => model.message(
                                        context,
                                        introMessage,
                                        (context, value, child) => (value
                                                    .introduction.status ==
                                                IntroductionDetails_IntroductionStatus
                                                    .PENDING)
                                            ? ContactListItem(
                                                contact: introductor,
                                                index: index,
                                                title: sanitizeContactName(value
                                                    .introduction.displayName),
                                                leading: CustomBadge(
                                                  showBadge: true,
                                                  top: 25,
                                                  // Render the countdown timer for the introduction's expiry
                                                  // the backend is taking care of assigning a different duration to these messages
                                                  customBadge: TweenAnimationBuilder<
                                                          int>(
                                                      key: Key(
                                                          'tween_${value.id}'),
                                                      tween: IntTween(
                                                          begin: DateTime.now()
                                                              .millisecondsSinceEpoch,
                                                          end: value.disappearAt
                                                              .toInt()),
                                                      duration: Duration(
                                                          milliseconds: value
                                                                  .disappearAt
                                                                  .toInt() -
                                                              value
                                                                  .firstViewedAt // we start counting from when the message containing the introduction is seen
                                                                  .toInt()),
                                                      curve: Curves.linear,
                                                      builder:
                                                          (BuildContext context,
                                                              int time,
                                                              Widget? child) {
                                                        var index = value.position(
                                                            segments:
                                                                value.segments(
                                                                    iterations:
                                                                        12));
                                                        return CustomAssetImage(
                                                            path: ImagePaths
                                                                    .countdownPaths[
                                                                index],
                                                            size: 12,
                                                            color:
                                                                Colors.black);
                                                      }),
                                                  child: CircleAvatar(
                                                    backgroundColor: avatarBgColors[
                                                        generateUniqueColorIndex(
                                                            value.introduction
                                                                .displayName)],
                                                    child: Text(
                                                        sanitizeContactName(value
                                                                .introduction
                                                                .displayName)
                                                            .substring(0, 2)
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                                trailing: FittedBox(
                                                    child: Row(
                                                  children: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          showAlertDialog(
                                                              context: context,
                                                              title: Text(
                                                                  'introductions_reject_title'
                                                                      .i18n,
                                                                  style:
                                                                      tsDialogTitle),
                                                              content: Text(
                                                                  'introductions_reject_content'
                                                                      .i18n,
                                                                  style:
                                                                      tsDialogBody),
                                                              // variable names are a bit confusing here: we are using the AlertDialog which by default has a [Reject vs Accept] field, but in this case these correspond to [Cancel vs Reject]
                                                              dismissText:
                                                                  'cancel'.i18n,
                                                              agreeText:
                                                                  'reject'.i18n,
                                                              agreeAction:
                                                                  () async {
                                                                try {
                                                                  // model.rejectIntroduction(from the person who is making the intro, to the person who they want to connect us to)
                                                                  await model.rejectIntroduction(
                                                                      introductor
                                                                          .contactId
                                                                          .id,
                                                                      value
                                                                          .introduction
                                                                          .to
                                                                          .id);
                                                                } catch (e) {
                                                                  showInfoDialog(
                                                                      context,
                                                                      title: 'error'
                                                                          .i18n,
                                                                      des: 'introductions_error_description'
                                                                          .i18n,
                                                                      icon: ImagePaths
                                                                          .alert_icon,
                                                                      buttonText:
                                                                          'OK'.i18n);
                                                                } finally {
                                                                  // TODO: pop router if we just went through all the requests
                                                                }
                                                              }),
                                                      child: Text(
                                                          'reject'
                                                              .i18n
                                                              .toUpperCase(),
                                                          style:
                                                              tsDialogButtonGrey),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        try {
                                                          // model.acceptIntroduction(from the person who is making the intro, to the person who they want to connect us to)
                                                          await model
                                                              .acceptIntroduction(
                                                                  introductor
                                                                      .contactId
                                                                      .id,
                                                                  value
                                                                      .introduction
                                                                      .to
                                                                      .id);
                                                        } catch (e) {
                                                          showInfoDialog(
                                                              context,
                                                              title:
                                                                  'error'.i18n,
                                                              des:
                                                                  'introductions_error_description_accepting'
                                                                      .i18n,
                                                              icon: ImagePaths
                                                                  .alert_icon,
                                                              buttonText:
                                                                  'OK'.i18n);
                                                        } finally {
                                                          showSnackbar(
                                                              context: context,
                                                              content: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      // TODO: add interpolation
                                                                      'Introduction to ${value.introduction.displayName} approved!'
                                                                          .i18n,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .visible,
                                                                      style: tsInfoDialogText(
                                                                          white),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          2000),
                                                              action:
                                                                  SnackBarAction(
                                                                textColor:
                                                                    secondaryPink,
                                                                label: 'start_chat'
                                                                    .i18n
                                                                    .toUpperCase(),
                                                                onPressed:
                                                                    () async {
                                                                  await context.pushRoute(Conversation(
                                                                      contactId: value
                                                                          .introduction
                                                                          .to));
                                                                },
                                                              ));

                                                          // TODO: pop router if we just went through all the requests
                                                        }
                                                      },
                                                      child: Text(
                                                          'accept'
                                                              .i18n
                                                              .toUpperCase(),
                                                          style:
                                                              tsDialogButtonPink),
                                                    )
                                                  ],
                                                )))
                                            : Container())),
                              ])),
                    );
                  },
                );
              })),
            ]));
  }
}
