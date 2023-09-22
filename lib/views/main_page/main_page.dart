import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/controllers/main_page_controller/main_page_controller.dart';
import 'package:tours_booking/main.dart';
import 'package:tours_booking/widgets/app_bottom_sheet.dart';

import '../../services/authentications/authentications_services.dart';
import '../bookings/ongoing_bookings.dart';
import '../registeration/login.dart';
import '../user_account/account_settings.dart';
import 'main_screens/all_packages.dart';
import 'main_screens/home_page.dart';

class MainPage extends StatefulWidget {
  final int currentIndex;
  const MainPage({
    Key? key,
    this.currentIndex = 1,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthenticationServices authervices = AuthenticationServices();

  final MainPageController controller = Get.put(MainPageController());
  bool isLogedIn = false;
  checkLogin() async {
    isLogedIn = box.get("loggedIn") ?? false;
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  Widget profileWidget() {
    return FutureBuilder(
      future: checkLogin(),
      builder: (context, snapshot) {
        if (isLogedIn) {
          return AccountSettings();
        } else {
          return const Login();
        }
      },
    );
  }

  Widget bookingWidget() {
    return FutureBuilder(
      future: checkLogin(),
      builder: (context, snapshot) {
        if (isLogedIn) {
          return const OngoingBookings();
        } else {
          return const Login();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> mainScreens = [
      const HomePage(),
      const AllPackages(),
      bookingWidget(),
      profileWidget(),
    ];
    MainPageController mainPageController = Get.put(MainPageController());
    mainPageController.currentIndex = widget.currentIndex;
    return ColoredBox(
      color: AppColors.backgroundcolor,
      child: SafeArea(
        child: GetBuilder<MainPageController>(
          init: MainPageController(),
          builder: (_) {
            return Scaffold(
              body: mainScreens[_.currentIndex],
              bottomNavigationBar: AppBottomSheet(
                currentIndex: _.currentIndex,
                onIndexChanged: (index) {
                  _.changeScreen(index);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
