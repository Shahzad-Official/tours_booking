import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/services/authentications/authentications_services.dart';
import 'package:tours_booking/utils/app_snackbar.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_input_field.dart';

import '../../constants/app_colors.dart';

import '../../services/registration/login_service.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final LoginService _loginService = LoginService();

  bool isObsecure = true;
  bool isLoading = false;

  bool _isEmailValid(String email) {
    String exp = r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(exp);
    return regExp.hasMatch(email);
  }

  bool _ispasswordvalid(String password) {
    String exp = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';

    RegExp regExp = RegExp(exp);
    return regExp.hasMatch(password);
  }

  isValidUser() async {
    if (email.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Email should not be empty",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (!_isEmailValid(email.text)) {
      Get.snackbar(
        "Error",
        "Email is invalid\nEmail must be like:- abc@gmail.com",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (password.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Password should not be empty",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (!_ispasswordvalid(password.text)) {
      Get.snackbar(
        "Error",
        "Password should contain minimum 8 characters with alphabets,numeric and special characters",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else {
      isLoading = true;
      update();
      await _loginService.loginUser(email: email.text, password: password.text);
      isLoading = false;
      update();
    }
    update();
  }

  passwordHide() {
    isObsecure = !isObsecure;
    update();
  }

  googleSignIn() async {
    isLoading = true;
    update();
    await _loginService.googleSignInService();
    isLoading = false;
    update();
  }

  facebookSignIn() async {
    isLoading = true;
    update();
    await _loginService.faceBookLoginService();
    isLoading = false;
    update();
  }

  TextEditingController forgetEmail = TextEditingController();
  bool resetLoading = false;
  forgetPassword() async {
    if (forgetEmail.text.isEmpty || !forgetEmail.text.isEmail) {
      AppSnackbar.snackBar(title: "Error", message: "Please enter valid email!");
    } else {
      Get.back();
      resetLoading = true;
      update();
      await AuthenticationServices().forgetPassword(email: forgetEmail.text);
      resetLoading = false;
      update();
    }
  }

  showResetPassDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    AppInputField(
                      hintText: "Email",
                      controller: forgetEmail,
                    ),
                    AppPadding.heightSpace20,
                    AppButton(
                      btnText: "Reset Password",
                      isLoading: resetLoading,
                      ontap: () async {
                        await forgetPassword();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
