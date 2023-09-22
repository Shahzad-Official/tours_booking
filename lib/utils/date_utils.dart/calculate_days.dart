import 'package:tours_booking/main.dart';

class CalculateDays {
  int hour = -1;
  int days = -1;
  bool isHours = false;
  bool isDays = false;
  int daysBetweenDates({
    required String endDate,
    required String endTime,
    required String startTime,
    String? startDate,
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

    DateTime newStartDate;
    if (startDate != null) {
      String endTimeHour = time12to24Format(endTime).split(":").first;

      String endTimeminute = time12to24Format(startTime).split(":").last;
      DateTime startDate1 = DateTime.parse(startDate.toString());
      newStartDate = DateTime(
        startDate1.year,
        startDate1.month,
        startDate1.day,
        int.parse(endTimeHour),
        int.parse(endTimeminute),
      );
    } else {
      newStartDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour,
        DateTime.now().minute,
      );
    }
    String endTimeHour = time12to24Format(endTime).split(":").first;

    String endTimeminute = time12to24Format(startTime).split(":").last;

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

  double priceLessInSecond = 0;

  remainingTimePercent({
    required String packageStartDateTime,
    required String packageEndDateTime,
    required String packageStartTime,
    required String packageEndTime,
    required String startPrice,
    required String endPrice,
  }) {
    var packageTotalRemainingTime = daysBetweenDates(
      endDate: packageEndDateTime,
      endTime: packageEndTime,
      startTime: packageStartTime,
      startDate: packageStartDateTime,
    );

    if (isDays) {
      var totalRemainingSeconds = packageTotalRemainingTime * 86400;
      priceLessInSecond = (double.parse(startPrice) - double.parse(endPrice)) / totalRemainingSeconds;
    } else if (isHours) {
      var totalRemainingSeconds = packageTotalRemainingTime * 3600;
      priceLessInSecond = (double.parse(startPrice) - double.parse(endPrice)) / totalRemainingSeconds;
    }

    // var packageCurrentRemainingTime = daysBetweenDates(
    //   endDate: packageEndDateTime,
    //   endTime: packageEndTime,
    //   startTime: packageStartTime,
    // );
    // var percentage = packageCurrentRemainingTime / packageTotalRemainingTime * 100;
    // return percentage;
  }
}
