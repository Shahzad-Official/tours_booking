class CalculateDays {
  static Duration daysBetweenDates({
    required String startDate,
    required String endDate,
  }) {
    DateTime newStartDate = DateTime.parse(startDate);
    DateTime newEndDate = DateTime.parse(endDate);
    return newEndDate.difference(newStartDate);
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
