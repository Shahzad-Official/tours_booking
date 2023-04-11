import 'package:flutter/foundation.dart';

class CalculateDays {
  static Duration daysBetweenDates({
    required String startDate,
    required String endDate,
  }) {
    DateTime newStartDate = DateTime.parse(endDate);
    DateTime newEndDate = DateTime.now();

    var diffrence = newStartDate.difference(newEndDate);

    return diffrence;
  }

  static DateTime dateDiffrence({
    required String startDate,
    required String endDate,
  }) {
    DateTime newStartDate = DateTime.parse(startDate);
    DateTime newEndDate = DateTime.parse(endDate);
    return DateTime.fromMillisecondsSinceEpoch(
        newEndDate.difference(newStartDate).inMilliseconds);
  }
}
