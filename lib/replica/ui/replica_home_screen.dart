import 'package:lantern/common/common.dart';
import 'package:lantern/replica/ui/common.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

/// ReplicaHomeScreen is the entrypoint for the user to search through Replica.
/// See docs/replica_home.png for a preview
class ReplicaHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReplicaHomeScreenState();
}

class _ReplicaHomeScreenState extends State<ReplicaHomeScreen> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'replicaSearchInput');
  late final _textEditingController =
      CustomTextEditingController(formKey: _formKey);

  // Two ways to navigate to seach screen:
  // - Click the magnifier icon next to the search bar
  // - Or, just click enter in the search bar
  Future<void> _navigateToSearchScreen(String query) async {
    await context.pushRoute(ReplicaSearchScreen(searchQuery: query));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Dismiss keyboard when clicking anywhere
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BaseScreen(
            actionButton: renderFap(context),
            centerTitle: true,
            title: 'discover'.i18n,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SearchField(
                      controller: _textEditingController,
                      search: (query) async {
                        await _navigateToSearchScreen(query);
                      }),
                ),
                renderDescription()
              ],
            )));
  }

  Widget renderDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
      child: CText('replica_search_intro'.i18n, style: tsBody1),
    );
  }

  FloatingActionButton renderFap(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: black,
      child: const CAssetImage(
        path: ImagePaths.file_upload,
      ),
      onPressed: () async {
        await onUploadButtonPressed(context);
      },
    );
  }
}
