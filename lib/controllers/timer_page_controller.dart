import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  DateTime? time;
  startTimer({required String timestamp}) async {
    DateTime startTime = DateTime.now();
    DateTime endTime = DateTime.parse(timestamp);
    DateTime newDate = DateTime.fromMillisecondsSinceEpoch(
        endTime.difference(startTime).inMilliseconds);

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        DateTime newTime = newDate.subtract(
          Duration(seconds: timer.tick),
        );
        time = newTime;
        update();
        if (newTime == DateTime.now()) {
          timer.cancel();

          update();
        }
      },
    );
  }
}
