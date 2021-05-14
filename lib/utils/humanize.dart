import 'package:intl/intl.dart';

/// Based on https://www.flutterclutter.dev/flutter/tutorials/date-format-dynamic-string-depending-on-how-long-ago/2020/229/
extension Humanize on int {
  String humanizeDate() {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    var now = DateTime.now();
    var justNow = now.subtract(const Duration(minutes: 1));
    var localDateTime = dateTime.toLocal();
    if (!localDateTime.difference(justNow).isNegative) {
      return 'just now'; // TODO: use i18n
    }
    var roughTimeString = DateFormat('jm').format(dateTime);
    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return roughTimeString;
    }
    var yesterday = now.subtract(const Duration(days: 1));
    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Yesterday'; // TODO: use i18n
    }
    if (now.difference(localDateTime).inDays < 4) {
      var weekday = DateFormat('EEEE').format(localDateTime);
      return '$weekday, $roughTimeString';
    }
    // TODO: Something is wrong with the year here
    return '${DateFormat('yMd').format(dateTime)}, $roughTimeString';
  }

  String humanizeDateSwitch() {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    final monthYear = DateFormat.yMMMMd('en_US').format(dateTime);
    return monthYear.split(',')[0];
  }

  String humanizeSeconds({bool longForm = false}) {
    // TODO: unit test this
    // TODO: localize the string portions of the below
    if (this < 60) {
      return toString() + (longForm ? ' seconds' : 's');
    }
    if (this < 3600) {
      return (this ~/ 60).toString() + (longForm ? ' minutes' : 'm');
    }
    if (this < 86400) {
      return (this ~/ 3600).toString() + (longForm ? ' hours' : 'h');
    }
    return (this ~/ 86400).toString() + (longForm ? ' days' : 'd');
  }
}
