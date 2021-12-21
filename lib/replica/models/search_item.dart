import 'package:filesize/filesize.dart';
import 'package:lantern/common/ui/humanize_seconds.dart';
import 'package:lantern/replica/models/replica_link.dart';
import 'package:lantern/replica/models/searchcategory.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class ReplicaSearchItem {
  ReplicaSearchItem(
    this.displayName,
    this.primaryMimeType,
    this.humanizedLastModified,
    this.humanizedFileSize,
    this.replicaLink,
  );

  String? primaryMimeType;
  String humanizedLastModified;
  String humanizedFileSize;
  late ReplicaLink replicaLink;
  late String displayName;

  static List<ReplicaSearchItem> fromJson(
    SearchCategory category,
    Map<String, dynamic> body,
  ) {
    var serverError = body['error'];
    if (serverError != null) {
      throw Exception(serverError);
    }

    var items = <ReplicaSearchItem>[];
    var results = body['objects'] as List<dynamic>;
    for (var result in results) {
      try {
        // Can't continue if replicaLink is not there
        final link = ReplicaLink.New(result['replicaLink'] as String);
        if (link == null) {
          logger.w('Bad replicaLink: ${result['replicaLink'] as String}');
          continue;
        }

        // primaryMimeType is optional
        String? primaryMimeType;
        if (result.containsKey('mimeTypes') &&
            result['mimeTypes'] is List<dynamic> &&
            (result['mimeTypes'] as List<dynamic>)[0] is String &&
            ((result['mimeTypes'] as List<dynamic>)[0] as String).isNotEmpty) {
          primaryMimeType = (result['mimeTypes'] as List<dynamic>)[0] as String;
        }

        // displayName, lastModified and fileSize are always there
        final humanizedLastModified = DateTime.now()
            .difference(DateTime.parse(result['lastModified'] as String))
            .inSeconds
            .humanizeSeconds();
        final humanizedFileSize = filesize(result['fileSize'] as int);
        final displayName = link.displayName ?? result['displayName'];

        items.add(
          ReplicaSearchItem(
            displayName,
            primaryMimeType,
            humanizedLastModified,
            humanizedFileSize,
            link,
          ),
        );
      } catch (err) {
        logger.w(
          'Error parsing item ${result['replicaLink'] ??= '[invalid link]'}. Will ignore link',
        );
        continue;
      }
    }
    return items;
  }
}
