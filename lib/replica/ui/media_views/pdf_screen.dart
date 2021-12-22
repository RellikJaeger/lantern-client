import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:lantern/common/common.dart';
import 'package:lantern/replica/logic/api.dart';
import 'package:lantern/replica/models/replica_link.dart';
import 'package:lantern/replica/models/replica_model.dart';
import 'package:lantern/replica/models/searchcategory.dart';
import 'package:lantern/replica/ui/common.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class ReplicaPDFScreen extends StatefulWidget {
  ReplicaPDFScreen({
    Key? key,
    required this.replicaApi,
    required this.replicaLink,
    required this.category,
    this.mimeType,
  });

  final ReplicaApi replicaApi;
  final ReplicaLink replicaLink;
  final SearchCategory category;
  final String? mimeType;

  @override
  ReplicaPDFScreenState createState() => ReplicaPDFScreenState();
}

class ReplicaPDFScreenState extends State<ReplicaPDFScreen> {
  String? tempFile;
  Future<void>? fetched;

  @override
  void initState() {
    super.initState();
    // Fetch to PDF to an application-specific temp file so that we can open it
    // in a PDFView.
    getTemporaryDirectory().then((tempDir) {
      setState(() {
        tempFile = '${tempDir.absolute.path}/${widget.replicaLink.infohash}';
        fetched = widget.replicaApi.fetch(widget.replicaLink, tempFile!);
      });
    });
  }

  @override
  void dispose() {
    // Delete the temp file when we're done viewing it.
    if (tempFile != null) {
      File(tempFile!).deleteSync();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return replicaModel.withReplicaApi(
      (context, replicaApi, child) {
        return renderReplicaMediaViewScreen(
          context: context,
          api: replicaApi,
          link: widget.replicaLink,
          backgroundColor: white,
          category: widget.category,
          mimeType: widget.mimeType,
          body: FutureBuilder(
            future: fetched,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                logger.e(
                  'Error loading PDF: ${snapshot.error}',
                );
              }

              return PDFView(
                filePath: tempFile,
              );
            },
          ),
        );
      },
    );
  }
}
