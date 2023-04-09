import 'package:flutter/material.dart';
import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/constants/app_padding.dart';

import 'package:tours_booking/widgets/app_button.dart';
import '../../widgets/app_text.dart';
import '../registeration/login.dart';
import '../registeration/sign_up.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.defaultPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset("assets/logo.png"),
              ),
              const AppText(
                text: "LOGO HERE",
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 20,
              ),
              const AppText(
                text: "Sign In to the application\nto enjoy!",
                textAlign: TextAlign.center,
                fontSize: 14,
              ),
              const SizedBox(
                height: 40,
              ),
              AppButton(
                btnText: "LOGIN",
                ontap: () {
                  //here use pushreplacement
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  //here use pushreplacement
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                child: Container(
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.primarycolor),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        color: Colors.white24,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: AppText(
                      text: "SIGN UP",
                      textcolor: AppColors.primarycolor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              AppPadding.heightSpace20,
            ],
          ),
        ),
      ),
    );
  }
}
