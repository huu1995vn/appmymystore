import 'package:flutter/material.dart';

class AppColors {
  static Paint backgroundColor = Paint()
    ..strokeWidth = 12
    ..color = primary
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;
  static const Color primary = Color(0xFFB71C1C);
  static const Color primary50 = Color(0xFFFFEBEE);
  static const Color primary100 = Color(0xFFFFCDD2);
  static const Color primary200 = Color(0xFFEF9A9A);
  static const Color primary300 = Color(0xFFE57373);
  static const Color primary400 = Color(0xFFEF5350);
  static const Color primary500 = Color(_redPrimaryValue);
  static const Color primary600 = Color(0xFFE53935);
  static const Color primary700 = Color(0xFFD32F2F);
  static const Color primary800 = Color(0xFFC62828);
  static const Color primary900 = Color(0xFFB71C1C);
  static const Color yellow = Color.fromARGB(214, 255, 196, 0);
  static const Color blue = Colors.blue;
  static const Color danger = Color(0xFFB71C1C);
  static const Color error = Color(0xFFB71C1C);
  static const Color warning = Color.fromARGB(255, 230, 185, 37);
  static const Color info = Color.fromARGB(255, 8, 171, 235);
  static const Color success = Color.fromARGB(179, 11, 226, 58);

  static const MaterialColor red = MaterialColor(
    _redPrimaryValue,
    <int, Color>{
      50: primary50,
      100: primary100,
      200: primary200,
      300: primary300,
      400: primary400,
      500: primary500,
      600: primary600,
      700: primary700,
      800: primary800,
      900: primary900,
    },
  );
  static const int _redPrimaryValue = 0xFFF44336;
  static const Color white = Color(0xffffffff);
  static const Color white50 = Color(0x88ffffff);
  static const Color grayDark = Color(0xffeaeaea);
  static const Color grey = Color(0xfff3f3f3);
  static const Color text = Color(0xff000000);
  static const Color text50 = Color(0x88000000);
  static const Color black = Color(0xff001424);
  static const Color black50 = Color(0x88001424);
  static const Color blackLight = Color(0xff011f35);
}
