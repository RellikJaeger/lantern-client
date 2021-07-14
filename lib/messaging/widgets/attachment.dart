import 'package:lantern/model/protos_flutteronly/messaging.pb.dart';
import 'package:lantern/package_store.dart';

import 'attachment_types/voice.dart';
import 'attachment_types/image.dart';
import 'attachment_types/video.dart';

/// Factory for attachment widgets that can render the given attachment.
Widget attachmentWidget(StoredAttachment attachment, bool inbound) {
  final attachmentTitle = attachment.attachment.metadata['title'];
  final mimeType = attachment.attachment.mimeType;
  // https://developer.android.com/guide/topics/media/media-formats
  switch (mimeType) {
    case 'application/ogg':
    case 'audio/ogg':
      return Flexible(child: VoiceMemo(attachment));
    case 'audio/mp4':
    case 'audio/m4a':
    case 'audio/mkv':
    case 'audio/mp3':
    case 'audio/flac':
    case 'audio/mpeg':
      return Flexible(
          child: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
                color: Colors.white,
              ),
              child: const Icon(Icons.audiotrack_rounded)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(
              attachmentTitle.toString(),
              style: TextStyle(
                color: inbound ? inboundMsgColor : outboundMsgColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ));
    case 'image/jpeg':
    case 'image/png':
    case 'image/bpm':
    case 'image/gif':
    case 'image/webp':
    case 'image/wav':
    case 'image/heif':
    case 'image/heic':
      return Flexible(child: ImageAttachment(attachment, inbound));
    case 'video/mp4':
    case 'video/mkv':
    case 'video/mov':
    case 'video/quicktime':
    case 'video/3gp':
    case 'video/webm':
      return Flexible(child: VideoAttachment(attachment, inbound));
    default:
      // render generic file type as an icon
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(Icons.file_copy,
                size: 30, color: inbound ? inboundMsgColor : outboundMsgColor),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150.0,
                  child: Text(
                    attachmentTitle.toString(),
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
                Text(attachmentTitle.toString().split('.')[1].toUpperCase(),
                    style: TextStyle(
                      color: inbound ? inboundMsgColor : outboundMsgColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ))
              ],
            )
          ],
        ),
      );
  }
}
