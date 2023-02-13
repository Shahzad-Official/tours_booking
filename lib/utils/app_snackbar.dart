import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

class AppSnackbar {
  static snackBar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.primarycolor,
      colorText: Colors.white,
    );
  }
}
