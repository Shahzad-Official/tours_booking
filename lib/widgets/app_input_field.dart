import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import 'app_text.dart';

class AppInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardtype;
  final Widget? suffixIcon, prefixIcon;
  final void Function()? onTap;
  final EdgeInsetsGeometry contentPadding;
  final bool? enabled;
  final double? width, height;
  final int? maxLines;
  final TextInputAction textInputAction;
  final int? maxLength;
  final void Function(String query)? onChanged;
  const AppInputField({
    Key? key,
    required this.hintText,
    this.controller,
    this.keyboardtype,
    this.obscureText = false,
    this.suffixIcon,
    this.contentPadding = const EdgeInsets.only(top: 15, left: 15),
    this.onTap,
    this.enabled,
    this.width,
    this.prefixIcon,
    this.height,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              color: Colors.grey.withOpacity(0.20),
              blurRadius: 8,
            ),
          ],
        ),
        child: TextFormField(
          onChanged: onChanged,
          maxLength: maxLength,
          maxLines: maxLines,
          textInputAction: textInputAction,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardtype,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: InputBorder.none,
            suffixIcon: suffixIcon,
            hintText: hintText,
            contentPadding: contentPadding,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.headTextColor,
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownContainer extends StatelessWidget {
  final Object? currentValue;
  final List<String> items;
  final void Function(Object? value)? onValueChange;
  const DropdownContainer({
    Key? key,
    required this.currentValue,
    required this.items,
    required this.onValueChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.20),
            blurRadius: 8,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: GoogleFonts.didactGothic(),
          value: currentValue,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Center(
                    child: AppText(
                      text: e,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textcolor: AppColors.headTextColor,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onValueChange,
          alignment: Alignment.center,
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 30,
            color: AppColors.primarycolor,
          ),
        ),
      ),
    );
  }
}
