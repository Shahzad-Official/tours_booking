import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../constants/app_colors.dart';

class EditProfileController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  String gender = "Male";
  List<String> genders = [
    "Male",
    "Female",
    "Other",
  ];
  changeGender(String value) {
    gender = value;
    update();
  }

  String? date;

  currentDate() {
    var date = DateTime.now();
    var formatedDate = DateFormat("dd-MM-yyyy").format(date);
    return formatedDate;
  }

  selectDate(context) async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2024),
    );

    if (selectedDate != null) {
      date = DateFormat("dd-MM-yyyy").format(selectedDate);
    }
    update();
    return date;
  }

  File? image;
  getimage(ImageSource source) async {
    var result = await ImagePicker.platform.getImage(source: source);
    if (result == null) return;

    image = File(result.path);
    update();
  }

  bool _isEmailValid(String email) {
    String exp =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(exp);
    return regExp.hasMatch(email);
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
    } else {}
  }
}
