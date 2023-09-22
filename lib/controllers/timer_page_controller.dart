import 'dart:async';

import 'package:get/get.dart';
import 'package:tours_booking/utils/date_utils.dart/calculate_days.dart';

class TimerController extends GetxController {
  CalculateDays calculateDays = CalculateDays();
  DateTime? time;
  double remainingPrice = 0;
  double percent = 0;
  startTimer({
    required String packageStartDateTime,
    required String packageEndDateTime,
    required String packageStartTime,
    required String packageEndTime,
    required String startPrice,
    required String endPrice,
  }) async {
    calculateDays.remainingTimePercent(
      packageStartDateTime: packageStartDateTime,
      packageEndDateTime: packageEndDateTime,
      packageStartTime: packageStartTime,
      packageEndTime: packageEndTime,
      startPrice: startPrice,
      endPrice: endPrice,
    );
    DateTime startTime = DateTime.now();
    DateTime endTime = DateTime.parse(packageEndDateTime);
    DateTime newDate = DateTime.fromMillisecondsSinceEpoch(endTime.difference(startTime).inMilliseconds);

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        remainingPrice = (double.parse(startPrice) - (calculateDays.priceLessInSecond * timer.tick));
        percent = ((double.parse(startPrice) - (calculateDays.priceLessInSecond * timer.tick)) / double.parse(startPrice));
        DateTime newTime = newDate.subtract(
          Duration(seconds: timer.tick),
        );
        time = newTime;
        update();
        if (newTime == DateTime.now()) {
          timer.cancel();

          update();
        }
        print(remainingPrice);
        print(percent);
      },
    );
  }
}
