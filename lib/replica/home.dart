import 'package:lantern/common/common.dart';
import 'package:lantern/replica/common.dart';
import 'package:lantern/replica/search.dart';

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
  late bool showResults = false;
  late String currentQuery = '';
  late int currentTab = 0;
  late bool showNewModal = false;

  @override
  void initState() {
    super.initState();
    replicaModel.getSearchTerm().then((String cachedSearchTerm) {
      if (cachedSearchTerm.isNotEmpty) {
        _textEditingController.initialValue = cachedSearchTerm;
        setState(() {
          currentQuery = cachedSearchTerm;
          showResults = true;
        });
      }
    });
    replicaModel.getShowNewBadge().then((bool showNewBadge) {
      if (showNewBadge) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          renderNewDialog(context);
        });
      }
    });
    doGetCachedTab();
  }

  void doGetCachedTab() async {
    final cachedTab = await replicaModel.getSearchTab();
    setState(() {
      currentTab = int.parse(cachedTab);
    });
  }

  @override
  Widget build(BuildContext context) {
    // We are showing the ReplicaSearchScreen here since we want the bottom tabs to be visible (they are not if it's its own route)
    // <08-23-22, kalli>  Not ideal UX - maybe add a spinner? Not sure
    // <09-07-22, kalli> Update after testing a debug build - this is not very noticeable.
    if (showResults) {
      return ReplicaSearchScreen(
        currentQuery: currentQuery,
        currentTab: currentTab,
      );
    }

    // No active query, return the landing search bar instead
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when clicking anywhere
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BaseScreen(
        actionButton: renderFap(context),
        centerTitle: true,
        title: 'discover'.i18n,
        body: Stack(
          children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.only(bottom: 46, top: 30),
                      child: CAssetImage(
                        path: ImagePaths.lantern_logo,
                        size: 72,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
                      child: SearchField(
                        controller: _textEditingController,
                        search: (query) async {
                          await replicaModel.setSearchTerm(query);
                          if (query != '') {
                            setState(() {
                              currentQuery = query;
                              showResults = true;
                            });
                          }
                        },
                        onClear: () async {
                          await replicaModel.setSearchTerm('');
                          await replicaModel.setSearchTab(0);
                        },
                      ),
                    ),
                    renderDiscoverText(),
                ],
              ),
            ),
            // if (!showNewModal) renderNewDialog(context)
          ],
        ),
      ),
    );
  }

  void Function() renderNewDialog(BuildContext context) {
    return CDialog(
      iconPath: ImagePaths.newspaper,
      title: 'replica_new_discover'.i18n,
      description: 'replica_new_discover_news'.i18n,
      agreeText: 'replica_check_it_out'.i18n,
      agreeAction: () async {
        await replicaModel.setShowNewBadge(false);
        return true;
      },
      includeCancel: false,
    ).show(context);
  }

  Widget renderDiscoverText() {
    return Padding(
      padding: const EdgeInsetsDirectional.all(12.0),
      child: Column(
        children: [
          CText('replica_search_intro'.i18n, style: tsBody1),
          const SizedBox(
            height: 8,
          ),
          CText('discover_disclaimer'.i18n, style: tsBody1),
        ],
      ),
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
