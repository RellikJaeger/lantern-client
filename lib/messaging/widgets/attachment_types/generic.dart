import 'package:lantern/package_store.dart';

class GenericAttachment extends StatelessWidget {
  const GenericAttachment({
    Key? key,
    required this.attachmentTitle,
    required this.inbound,
    required this.icon,
  }) : super(key: key);

  final String? attachmentTitle;
  final bool inbound;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final fileType = attachmentTitle.toString().split('.')[1];
    final title = attachmentTitle.toString().split('.')[0];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // TODO: create a utils function that looks up file extension and returns corresponding icon
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: inbound ? inboundMsgColor : outboundMsgColor,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          child: Icon(icon,
              size: 30, color: inbound ? inboundMsgColor : outboundMsgColor),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150.0,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  color: inbound ? inboundMsgColor : outboundMsgColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(height: 2.0),
            Text(fileType.toUpperCase(),
                style: TextStyle(
                  color: inbound ? inboundMsgColor : outboundMsgColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ))
          ],
        )
      ],
    );
  }
}
