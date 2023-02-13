import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/authentications/authentications_services.dart';

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
