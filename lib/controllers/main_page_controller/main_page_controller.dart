import 'package:get/get.dart';

class MainPageController extends GetxController {
  int currentIndex = 0;

  List<String> mainScreensTitle = [
    "Create Tour",
    "All Tours",
    "Ongoing Bookings",
    "Account",
  ];
  changeScreen(int index) {
    currentIndex = index;
    update();
  }
}
