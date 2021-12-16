import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lantern/common/common.dart';
import 'package:lantern/common/ui/colors.dart';
import 'package:lantern/common/ui/custom/asset_image.dart';
import 'package:lantern/common/ui/custom/list_item_factory.dart';
import 'package:lantern/common/ui/custom/text.dart';
import 'package:lantern/common/ui/image_paths.dart';
import 'package:lantern/common/ui/text_styles.dart';
import 'package:lantern/replica/logic/api.dart';
import 'package:lantern/replica/models/search_item.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class ReplicaVideoListItem extends StatefulWidget {
  ReplicaVideoListItem(
      {required this.item, required this.onTap, required this.replicaApi});

  final ReplicaSearchItem item;
  final Function() onTap;
  final ReplicaApi replicaApi;

  @override
  State<StatefulWidget> createState() => _ReplicaVideoListItem();
}

// XXX <30-11-2021> soltzen: Fetching metadata for this list item goes like this:
// - The video duration is fetched in initState(): if it works, setState is
//   called for a rebuild
// - The thumbnail is fetched with CachedNetworkVideo in build():
//   - During the fetch, a progress indicator is shown
//   - After a successful fetch, the thumbnail is rendered
//   - After a failed fetch, a black box is rendered
class _ReplicaVideoListItem extends State<ReplicaVideoListItem> {
  late Future<double?> _fetchDurationFuture;

  @override
  void initState() {
    _fetchDurationFuture =
        widget.replicaApi.fetchDuration(widget.item.replicaLink);
    super.initState();
  }

  // renderMetadata() fetches a thumbnail from Replica and renders it.
  // CachedNetworkVideo takes care of the caching for list items in a sensible way.
  // If there's no duration (i.e., request failed), don't render it.
  // If there's no thumbnail (i.e., request failed), render a black box
  Widget renderMetadata() {
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(top: 8, bottom: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .45,
                  height: 100,
                  child: Image(
                    image: imageProvider,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 8,
                bottom: 4,
                child: renderDurationTextbox(),
              ),
              PlayButton(custom: true),
            ],
          ),
        );
      },
      imageUrl: widget.replicaApi.getThumbnailAddr(widget.item.replicaLink),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) {
        // XXX <02-12-2021> soltzen: if an error occurs, show a black box.
        // This is common in Replica since we just recently deployed a
        // metadata materialization service
        // (https://github.com/getlantern/replica-infrastructure/pull/30) and
        // metadata is not fully available.
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(color: Colors.black),
            ),
            renderDurationTextbox(),
            const Center(
                child: CAssetImage(path: ImagePaths.play_circle_filled)),
          ],
        );
      },
    );
  }

  Widget renderDurationTextbox() {
    return FutureBuilder(
      future: _fetchDurationFuture,
      builder: (BuildContext context, AsyncSnapshot<double?> snapshot) {
        // if we got an error,
        // or, didn't receive data,
        // or, got null data,
        // display render nothing
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            padding: const EdgeInsetsDirectional.only(
              start: 8,
              end: 8,
              bottom: 2,
            ),
            decoration: BoxDecoration(color: black),
            child: CText(
              Duration(seconds: snapshot.data!.toInt())
                  .toString()
                  .substring(2, 7),
              style: tsOverline.copiedWith(color: white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListItemFactory.replicaItem(
      height: 116,
      link: widget.item.replicaLink,
      api: widget.replicaApi,
      onTap: widget.onTap,
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          renderMetadata(),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(8.0),
              child: CText(
                widget.item.displayName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: tsBody1Short.copiedWith(color: blue4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
