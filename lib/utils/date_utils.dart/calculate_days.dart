class CalculateDays {
  static int daysBetweenDates({
    required String startDate,
    required String endDate,
  }) {
    DateTime newStartDate = DateTime.parse(startDate);
    DateTime newEndDate = DateTime.parse(endDate);
    int days = newEndDate.difference(newStartDate).inDays;
    int hours = newEndDate.difference(newStartDate).inHours;
    if (days >= 0) {
      return hours;
    } else {
      return days;
    }
  }
}
