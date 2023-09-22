import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tours_booking/constants/app_colors.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/constants/svg_icons.dart';
import 'package:tours_booking/controllers/registration_controllers/login_controller.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_input_field.dart';

import '../../widgets/app_text.dart';
import 'sign_up.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.backgroundcolor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (logincontroller) {
              return Stack(
                children: [
                  Padding(
                    padding: AppPadding.defaultPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 70,
                          child: Image.asset("assets/logo.png"),
                        ),
                        const AppText(
                          text: "LOGO HERE",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AppInputField(
                          hintText: "Enter Username",
                          controller: logincontroller.email,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AppInputField(
                          hintText: "Password",
                          controller: logincontroller.password,
                          obscureText: logincontroller.isObsecure,
                          maxLines: 1,
                          contentPadding: const EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              logincontroller.passwordHide();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: logincontroller.isObsecure ? 20 : 15,
                              ),
                              child: SvgPicture.string(
                                logincontroller.isObsecure ? SvgIcons.closeEye : SvgIcons.openEye,
                                width: 30,
                                // ignore: deprecated_member_use
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GetBuilder<LoginController>(
                          init: LoginController(),
                          initState: (_) {},
                          builder: (_) {
                            return InkWell(
                              onTap: () {
                                _.showResetPassDialog(context);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AppText(text: "Forget Password"),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AppButton(
                          btnText: "LOGIN",
                          isLoading: logincontroller.isLoading,
                          ontap: () async {
                            await logincontroller.isValidUser();
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * 0.15,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const AppText(
                              text: "Or continue with",
                              textcolor: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * 0.15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: logincontroller.isLoading
                                  ? null
                                  : () async {
                                      await logincontroller.googleSignIn();
                                    },
                              child: SizedBox(
                                height: 80,
                                child: Image.asset("assets/googleLogo.png"),
                              ),
                            ),
                            InkWell(
                              onTap: logincontroller.isLoading
                                  ? null
                                  : () async {
                                      await logincontroller.facebookSignIn();
                                    },
                              child: SizedBox(
                                height: 80,
                                child: Image.asset("assets/fLogo.png"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Not a member? ",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignUp(),
                                      ),
                                    );
                                  },
                                text: "Sign Up",
                                style: GoogleFonts.poppins(
                                  color: Colors.blueAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  logincontroller.resetLoading
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black54,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
