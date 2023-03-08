import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_booking/services/registration/signup_service.dart';

import '../../constants/app_colors.dart';

class SignupController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final SignupService _signupService = SignupService();
  bool isObsecure = true;
  bool isLoading = false;

  changeCheckValue(value) {
    isObsecure = value;
    update();
  }

  bool _isEmailValid(String email) {
    String exp =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(exp);
    return regExp.hasMatch(email);
  }

  bool _ispasswordvalid(String password) {
    String exp =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';

    RegExp regExp = RegExp(exp);
    return regExp.hasMatch(password);
  }

  hidePassword() {
    isObsecure = !isObsecure;
    update();
  }

  isValidUser() async {
    if (name.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Name should not be empty",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (email.text.trim().isEmpty) {
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
    } else if (phone.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Phone Number should not be empty",
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
    } else if (password.text.trim().length < 6) {
      Get.snackbar(
        "Error",
        "Password length should be 6",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (confirmPassword.text.trim() != password.text.trim()) {
      Get.snackbar(
        "Error",
        "Password Does not matched",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else {
      isLoading = true;
      update();
      await _signupService.registerUser(
        userName: name.text,
        email: email.text,
        phoneNo: phone.text,
        password: password.text,
        confirmPassword: confirmPassword.text,
      );
      isLoading = false;
      update();
    }
  }

  googleSignUp() async {
    isLoading = true;
    update();
    await _signupService.googleSignUpService();
    isLoading = false;
    update();
  }

  facebookSignUp() async {
    isLoading = true;
    update();
    await _signupService.faceBookSignUpService();
    isLoading = false;
    update();
  }
}
