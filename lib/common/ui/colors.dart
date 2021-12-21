import 'package:crypto/crypto.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lantern/messaging/messaging.dart';

Color transparent = Colors.transparent;

Color blue1 = HexColor('#EFFDFF');
Color blue3 = HexColor('#00BCD4');
Color blue4 = HexColor('#007A7C');
Color blue5 = HexColor('#006163');

Color yellow3 = HexColor('#FFE600');
Color yellow4 = HexColor('#FFC107');
Color yellow6 = HexColor('#957000');

Color pink3 = HexColor('#FF4081');
Color pink4 = HexColor('#DB0A5B');

// Grey scale
Color white = HexColor('#FFFFFF');
Color grey1 = HexColor('#F9F9F9');
Color grey2 = HexColor('#F5F5F5');
Color grey3 = HexColor('#EBEBEB');
Color grey4 = HexColor('#BFBFBF');
Color grey5 = HexColor('#707070');
Color scrimGrey = HexColor('#C4C4C4');
Color black = HexColor('#000000');

// Avatars
Color getAvatarColor(double hue, {bool inverted = false}) {
  return HSLColor.fromAHSL(1, hue, 1, 0.3).toColor();
}

final maxSha1Hash = BigInt.from(2).pow(160);
final numHues = BigInt.from(360);

double sha1Hue(String value) {
  var bytes = utf8.encode(value);
  var digest = sha1.convert(bytes);
  return (BigInt.parse(digest.toString(), radix: 16) * numHues ~/ maxSha1Hash)
      .toDouble();
}

// Indicator
Color indicatorGreen = HexColor('#00A83E');
Color indicatorRed = HexColor('#D5001F');

// Overlay
Color overlayBlack = HexColor('#000000CB');

// Checkbox color helper
Color getCheckboxFillColor(Color activeColor, Set<MaterialState> states) {
  const interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  return states.any(interactiveStates.contains) ? white : activeColor;
}

Color getIllustrationColor(Contact contact) {
  return getAvatarColor(sha1Hue(contact.contactId.id));
}

// Button colors
Color getBgColor(bool secondary, bool disabled, bool tertiary) {
  if (secondary) return white;
  if (tertiary) return black;
  if (disabled) return grey5;
  return pink4;
}

Color getBorderColor(bool disabled, bool tertiary) {
  if (tertiary) return black;
  if (disabled) return grey5;
  return pink4;
}

/*
******************
REUSABLE COLORS
******************
*/

Color outboundBgColor = blue4;
Color outboundMsgColor = white;

Color inboundMsgColor = black;
Color inboundBgColor = grey2;

Color snippetShadowColor = black.withOpacity(0.18);

Color selectedTabColor = white;
Color unselectedTabColor = grey1;

Color selectedTabIconColor = black;
Color unselectedTabIconColor = grey5;

Color borderColor = grey3;

Color onSwitchColor = blue3;
Color offSwitchColor = grey5;
Color usedDataBarColor = blue4;
