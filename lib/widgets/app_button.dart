import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tours_booking/widgets/app_text.dart';

import '../constants/app_colors.dart';

class AppButton extends StatelessWidget {
  String btnText;
  void Function() ontap;
  bool isLoading;
  final double? width;
  final EdgeInsetsGeometry? margin;
  AppButton({
    Key? key,
    required this.btnText,
    this.margin,
    this.isLoading = false,
    required this.ontap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 58,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color(0xff6CCAFF),
              Color(0xff39ACFF),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 3,
              color: Colors.grey,
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SpinKitThreeBounce(
                  size: 20,
                  color: Colors.white,
                )
              : AppText(
                  text: btnText,
                  textcolor: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
        ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  double? width;
  String text;
  double? fontSize;
  Color? textColor, buttonColor;
  void Function()? onTap;
  RoundButton({
    Key? key,
    this.width,
    required this.text,
    this.onTap,
    this.fontSize,
    this.textColor,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColors.primarycolor,
          ),
          color: buttonColor ?? AppColors.primarycolor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 3,
            bottom: 5,
          ),
          child: AppText(
            text: text,
            fontWeight: FontWeight.w700,
            fontSize: fontSize ?? 12,
            textcolor: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
