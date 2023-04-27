class CalculateDays {
  static int daysBetweenDates({
    required String endDate,
  }) {
    DateTime newStartDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    DateTime newEndDate = DateTime.parse(endDate);

    return newEndDate.difference(newStartDate).inDays;
  }
}
