import 'package:lantern/common/common.dart';
import 'package:lantern/replica/ui/common.dart';
import 'package:lantern/replica/ui/listviews/app_listview.dart';
import 'package:lantern/replica/ui/listviews/audio_listview.dart';
import 'package:lantern/replica/ui/listviews/document_listview.dart';
import 'package:lantern/replica/ui/listviews/video_listview.dart';
import 'package:lantern/replica/ui/listviews/image_listview.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

// ReplicaSearchScreen renders a text field with a TabBar to display the
// different categories. Each category is a child of ListView (except the
// 'image' tab, which is a child of GridView)
// Looks like this: docs/replica_search_tabs.png
class ReplicaSearchScreen extends StatefulWidget {
  ReplicaSearchScreen({Key? key, required this.searchQuery});
  final String searchQuery;

  @override
  _ReplicaSearchScreenState createState() =>
      _ReplicaSearchScreenState(searchQuery);
}

class _ReplicaSearchScreenState extends State<ReplicaSearchScreen>
    with TickerProviderStateMixin {
  late ValueNotifier<String> _searchQueryListener;
  late final TabController _tabController =
      // Video + Image + Audio + Document + App = 5 categories
      TabController(length: 5, vsync: this);
  late final TextEditingController _textEditingController;

  _ReplicaSearchScreenState(String searchQuery) {
    _textEditingController = TextEditingController(text: searchQuery);
    _searchQueryListener = ValueNotifier<String>(searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        centerTitle: true,
        title: 'discover'.i18n,
        actions: [
          IconButton(
              onPressed: () async {
                await onUploadButtonPressed(context);
              },
              icon: CAssetImage(
                size: 20,
                path: ImagePaths.file_upload,
                color: black,
              )),
        ],
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 30),
            renderReplicaSearchTextField(
                onPressed: (query) async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    _searchQueryListener.value = _textEditingController.text;
                  });
                },
                textEditingController: _textEditingController),
            const SizedBox(height: 10),
            TabBar(
              controller: _tabController,
              unselectedLabelStyle: tsBody1,
              unselectedLabelColor: grey5,
              indicatorColor: indicatorRed,
              isScrollable: true,
              labelStyle: tsSubtitle2,
              labelColor: pink4,
              tabs: <Widget>[
                Tab(
                  text: 'video'.i18n,
                ),
                Tab(
                  text: 'image'.i18n,
                ),
                Tab(
                  text: 'audio'.i18n,
                ),
                Tab(
                  text: 'document'.i18n,
                ),
                Tab(
                  text: 'app'.i18n,
                ),
              ],
            ),
            const SizedBox(height: 10),
            // TODO <17-12-2021> soltzen: ValueListenableBuilder may not be
            // necessary: try without it (just with setState and see)
            ValueListenableBuilder<String>(
                valueListenable: _searchQueryListener,
                builder: (BuildContext context, String value, Widget? child) {
                  return Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    children: [
                      ReplicaVideoListView(searchQuery: value),
                      ReplicaImageListView(searchQuery: value),
                      ReplicaAudioListView(searchQuery: value),
                      ReplicaDocumentListView(searchQuery: value),
                      ReplicaAppListView(searchQuery: value),
                    ],
                  ));
                }),
          ],
        ));
  }
}
