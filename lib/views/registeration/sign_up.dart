import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/controllers/registration_controllers/signup_controller.dart';
import 'package:tours_booking/services/registration/signup_service.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_input_field.dart';
import 'package:tours_booking/widgets/app_text.dart';

import '../../constants/svg_icons.dart';
import 'login.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final SignupService _signUpService = SignupService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: AppText(
          text: "Create Account",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          textcolor: const Color(0xff302A4E),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.defaultPadding,
          child: GetBuilder<SignupController>(
              init: SignupController(),
              builder: (signupController) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    AppInputField(
                      hintText: "Username",
                      controller: signupController.name,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AppInputField(
                      hintText: "Email",
                      controller: signupController.email,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AppInputField(
                      hintText: "Phone Number",
                      controller: signupController.phone,
                      keyboardtype: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        AppInputField(
                          controller: signupController.password,
                          obscureText: signupController.isObsecure,
                          hintText: "Password",
                          contentPadding: const EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              signupController.hidePassword();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: signupController.isObsecure ? 20 : 15,
                              ),
                              child: SvgPicture.string(
                                signupController.isObsecure
                                    ? SvgIcons.closeEye
                                    : SvgIcons.openEye,
                                width: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        AppPadding.heightSpace30,
                        AppInputField(
                          controller: signupController.confirmPassword,
                          obscureText: signupController.isObsecure,
                          contentPadding: const EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              signupController.hidePassword();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: signupController.isObsecure ? 20 : 15,
                              ),
                              child: SvgPicture.string(
                                signupController.isObsecure
                                    ? SvgIcons.closeEye
                                    : SvgIcons.openEye,
                                width: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          hintText: "Repeat Password",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "By continuing, you agree to our ",
                            style: GoogleFonts.poppins(
                              color: const Color(0xff918AB1),
                            ),
                          ),
                          TextSpan(
                            text: "Terms of Service ",
                            style: GoogleFonts.poppins(
                              color: Colors.blueAccent,
                            ),
                          ),
                          TextSpan(
                            text: "and ",
                            style: GoogleFonts.poppins(
                              color: const Color(0xff918AB1),
                            ),
                          ),
                          TextSpan(
                            text: "Privacy policy ",
                            style: GoogleFonts.poppins(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppButton(
                      btnText: "SIGN UP",
                      isLoading: signupController.isLoading,
                      ontap: () async {
                        await signupController.isValidUser();
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await _signUpService.googleSignUpService();
                          },
                          child: SizedBox(
                            height: 80,
                            child: Image.asset("assets/googleLogo.png"),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _signUpService.faceBookSignUpService();
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
                            text: "Already have an account?",
                            style: GoogleFonts.poppins(
                              color: const Color(0xff918AB1),
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  ),
                            text: " Login",
                            style: GoogleFonts.poppins(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
