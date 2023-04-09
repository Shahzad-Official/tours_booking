import 'package:flutter/material.dart';
import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/views/main_page/main_page.dart';
import 'package:tours_booking/widgets/app_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      ),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset("assets/logo.png"),
            ),
            AppText(
              text: "LOGO HERE",
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            AppPadding.heightSpace20,
            const SpinKitCircle(
              color: AppColors.primarycolor,
            ),
          ],
        ),
      ),
    );
  }
}
