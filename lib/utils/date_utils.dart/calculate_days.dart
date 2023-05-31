class CalculateDays {
  static int daysBetweenDates({
    required String endDate,
  }) {
    DateTime newStartDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
    );
    DateTime newEndDate = DateTime.parse(endDate);

    return newEndDate.difference(newStartDate).inDays;
  }
}
