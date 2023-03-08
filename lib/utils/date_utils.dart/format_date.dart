import 'package:intl/intl.dart';

class FormatDate {
  static String formatedDate({
    required String formatPattern,
    required String date,
  }) {
    DateTime newDate = DateTime.parse(date);
    return DateFormat(formatPattern).format(newDate);
  }
}
