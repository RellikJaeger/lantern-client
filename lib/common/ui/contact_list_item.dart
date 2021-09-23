import 'package:lantern/messaging/messaging.dart';

/*
* Generic widget that renders a row with a Contact avatar, a Contact name and a trailing widget. 
* Used in displaying lists of messages, contacts and contact requests.
*/
class ContactListItem extends StatelessWidget {
  ContactListItem({
    Key? key,
    required this.contact,
    required this.index,
    this.isContactPreview,
    required this.title,
    this.subtitle,
    required this.leading,
    required this.trailing,
    this.onTap,
    this.disableBorders = false,
  }) : super();

  final Contact contact;
  final int index;
  final bool? isContactPreview;
  final String title;
  final Widget? subtitle;
  final Widget leading;
  final Widget? trailing;
  final void Function()? onTap;
  final bool disableBorders;

  @override
  Widget build(BuildContext context) => Wrap(
        children: [
          if (!disableBorders)
            const CDivider(
                size: 1,
                thickness: 0.5,
                margin: 16,
                color: Color.fromRGBO(235, 235, 235, 1)),
          CListTile(
              leading: Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: leading,
              ),
              content: Wrap(
                direction: Axis.vertical,
                children: [
                  CText(title.toString(), maxLines: 1, style: tsSubtitle1Short),
                  subtitle ?? const SizedBox(),
                ],
              ),
              trailing: Padding(
                padding: const EdgeInsetsDirectional.only(end: 8.0),
                child: trailing ?? const SizedBox(),
              ),
              onTap: onTap),
          if (!disableBorders)
            const CDivider(
                size: 1,
                thickness: 0.5,
                margin: 16,
                color: Color.fromRGBO(235, 235, 235, 1)),
        ],
      );
}
