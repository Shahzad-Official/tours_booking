import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FormatDate {
  static String formatedDate({
    required String formatPattern,
    required String date,
  }) {
    DateTime newDate = DateTime.parse(date);
    return DateFormat(formatPattern).format(newDate);
  }

  static String formatDateFromTimeStamp({
    required String formatPattern,
    required Timestamp timestamp,
  }) {
    DateTime newDate =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    return DateFormat(formatPattern).format(newDate);
  }
}
