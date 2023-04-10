import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? textcolor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  const AppText({
    Key? key,
    required this.text,
    this.textcolor,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.overflow,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textcolor,
        decoration: decoration,
      ),
      overflow: overflow,
    );
  }
}
