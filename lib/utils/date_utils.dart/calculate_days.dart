class CalculateDays {
  static int daysBetweenDates({
    required String endDate,
  }) {
    DateTime newStartDate = DateTime.now();
    DateTime newEndDate = DateTime.parse(endDate);
    return DateTime.fromMillisecondsSinceEpoch(
            newEndDate.difference(newStartDate).inMilliseconds)
        .day;
  }

  static int dateDiffrence({
    required String endDate,
  }) {
    DateTime newStartDate = DateTime.now();
    DateTime newEndDate = DateTime.parse(endDate);
    return DateTime.fromMillisecondsSinceEpoch(
            newEndDate.difference(newStartDate).inMilliseconds)
        .day;
  }
}
