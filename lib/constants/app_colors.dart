import 'package:flutter/material.dart';

class AppColors {
  static const primarycolor = Color(0xFF3FAFFF);
  static const backgroundcolor = Color(0xffFFFFFF);
  static const headTextColor = Color(0xff8E89A9);
  Map<int, Color> color = const {
    50: Color.fromRGBO(63, 175, 255, .1),
    100: Color.fromRGBO(63, 175, 255, .2),
    200: Color.fromRGBO(63, 175, 255, .3),
    300: Color.fromRGBO(63, 175, 255, .4),
    400: Color.fromRGBO(63, 175, 255, .5),
    500: Color.fromRGBO(63, 175, 255, .6),
    600: Color.fromRGBO(63, 175, 255, .7),
    700: Color.fromRGBO(63, 175, 255, .8),
    800: Color.fromRGBO(63, 175, 255, .9),
    900: Color.fromRGBO(63, 175, 255, 1),
  };
  getMaterialColor() {
    return MaterialColor(0xFF3FAFFF, color);
  }
}
