import 'dart:typed_data';

import 'package:lantern/package_store.dart';

class BasicMemoryImage extends Image {
  BasicMemoryImage(
    Uint8List bytes, {
    FilterQuality filterQuality = FilterQuality.high,
    double scale = 1,
    double? width,
    double? height,
    ImageErrorWidgetBuilder? errorBuilder,
  }) : super(
          image: MemoryImage(bytes, scale: scale),
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if ((child as RawImage).image == null) {
              // the first time an image is rendered, the RawImage will be null
              // because Flutter hasn't decoded the in-memory image yet. To
              // prevent layout errors, return an empty SizedBox as a placeholder.
              return const SizedBox(width: 1, height: 1);
            }
            return child;
          },
          errorBuilder: errorBuilder,
          filterQuality: filterQuality,
          width: width,
          height: height,
          excludeFromSemantics: true,
          fit: BoxFit.contain,
          alignment: Alignment.center,
          repeat: ImageRepeat.noRepeat,
        );
}
