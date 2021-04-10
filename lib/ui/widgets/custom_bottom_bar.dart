import 'package:lantern/model/vpn_model.dart';
import 'package:lantern/package_store.dart';
import 'package:lantern/utils/hex_color.dart';

class CustomBottomBar extends StatefulWidget {
  final int currentIndex;
  final Function updateCurrentIndexPageView;

  CustomBottomBar(
      {this.currentIndex = 0,
      required this.updateCurrentIndexPageView,
      Key? key})
      : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  Widget activeIcon({bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      height: activeIconSize,
      width: activeIconSize,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.red,
        borderRadius: const BorderRadius.all(
          Radius.circular(activeIconSize / 2),
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.green.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ]
            : [],
      ),
    );
  }

  Widget renderBottomTabItem(
      {required TAB_ENUM tabEnum, required int index, bool isActive = false}) {
    String text;
    late IconData icon;

    switch (tabEnum) {
      case TAB_ENUM.MESSAGING:
        text = 'Messaging'.i18n;
        icon = Icons.message;
        break;
      case TAB_ENUM.VPN:
        text = 'VPN'.i18n;
        icon = Icons.vpn_key;
        break;
      case TAB_ENUM.ACCOUNT:
        text = 'Account'.i18n;
        icon = Icons.account_circle;
        break;
      default:
        throw Exception('unknown tabEnum');
    }
    return Expanded(
      flex: 1,
      child: InkWell(
        // customBorder: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(
        //       index != 0 ? borderRadius : 0,
        //     ),
        //     topRight: Radius.circular(index != TAB_ENUM.values.length - 1 ? borderRadius : 0),
        //   ),
        // ),
        onTap: () => widget.updateCurrentIndexPageView(index),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              index != 0 ? borderRadius : 0,
            ),
            topRight: Radius.circular(
                index != TAB_ENUM.values.length - 1 ? borderRadius : 0),
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: HexColor(widget.currentIndex == index
                  ? selectedTabColor
                  : unselectedTabColor),
              border: Border(
                top: BorderSide(
                  color: widget.currentIndex == index
                      ? Colors.white
                      : HexColor(borderColor),
                  width: 1,
                ),
                right: BorderSide(
                  color: HexColor(borderColor),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: HexColor(widget.currentIndex == index
                      ? selectedTabLabelColor
                      : unselectedTabLabelColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: tsCaption(context)?.copyWith(
                        color: HexColor(widget.currentIndex == index
                            ? selectedTabLabelColor
                            : unselectedTabLabelColor),
                      ),
                    ),
                    tabEnum == TAB_ENUM.VPN
                        ? activeIcon(isActive: isActive)
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var vpnModel = context.watch<VpnModel>();
    return Container(
      height: 68,
      child: vpnModel
          .vpnStatus((BuildContext context, String? vpnStatus, Widget? child) {
        return Row(
          children: TAB_ENUM.values
              .asMap()
              .map(
                (index, tabEnum) => MapEntry(
                  index,
                  renderBottomTabItem(
                    index: index,
                    tabEnum: tabEnum,
                    isActive: (vpnStatus == 'connected' ||
                        vpnStatus == 'disconnecting'),
                  ),
                ),
              )
              .values
              .toList(),
        );
      }),
    );
  }
}
