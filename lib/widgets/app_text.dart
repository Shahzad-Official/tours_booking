import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  String text;
  Color? textcolor;
  double? fontSize;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  AppText({
    Key? key,
    required this.text,
    this.textcolor,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        textAlign: textAlign,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textcolor,
        ),
      ),
    );
  }
}
