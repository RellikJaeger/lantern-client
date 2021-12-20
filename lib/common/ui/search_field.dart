import 'package:lantern/common/common.dart';

class SearchField extends CTextField {
  SearchField(
      {required CustomTextEditingController controller,
      required Future<void> Function(String query) search})
      : super(
          controller: controller,
          onFieldSubmitted: (query) async {
            await search(query);
          },
          label: 'search'.i18n,
          textInputAction: TextInputAction.search,
          suffixIcon: ValueListenableBuilder(
            valueListenable: controller,
            builder: (BuildContext context, TextEditingValue value, _) =>
                value.text.isEmpty
                    ? Container()
                    : CInkWell(
                        child: CAssetImage(
                          path: ImagePaths.cancel,
                          size: 48,
                          color: black,
                        ),
                        onTap: () {
                          controller.clear();
                        },
                      ),
          ),
          actionIconPath: ImagePaths.search,
        );
}
