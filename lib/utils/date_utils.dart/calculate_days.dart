class CalculateDays {
  int hour = -1;
  int days = -1;
  bool isHours = false;
  bool isDays = false;
  int daysBetweenDates({
    required String endDate,
    required String endTime,
    required String startTime,
  }) {
    String time12to24Format(String time) {
      int h = int.parse(time.split(":").first);
      int m = int.parse(time.split(":").last.split(" ").first);
      String meridium = time.split(":").last.split(" ").last.toLowerCase();
      if (meridium == "pm") {
        if (h != 12) {
          h = h + 12;
        }
      }
      if (meridium == "am") {
        if (h == 12) {
          h = 00;
        }
      }
      String newTime = "${h == 0 ? "00" : h}:${m == 0 ? "00" : m}";

      return newTime;
    }

    String endTimeHour = time12to24Format(endTime).split(":").first;

    String endTimeminute = time12to24Format(startTime).split(":").last;
    DateTime newStartDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
    );

    DateTime endDate2 = DateTime.parse(endDate);
    DateTime newEndDate = DateTime(
      endDate2.year,
      endDate2.month,
      endDate2.day,
      int.parse(endTimeHour),
      int.parse(endTimeminute),
    );
    int hours = newEndDate.difference(newStartDate).inHours;

    if (!hours.isNegative && hours > 24) {
      days = newEndDate.difference(newStartDate).inDays;
      isHours = false;
      isDays = true;
      return days;
    } else if (hours > 0) {
      hour = newEndDate.difference(newStartDate).inHours;
      isHours = true;
      isDays = false;
      return hour;
    } else {
      return -1;
    }
  }
}
