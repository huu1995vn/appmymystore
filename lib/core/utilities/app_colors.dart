import 'package:flutter/material.dart';

class AppColors {
  static Paint backgroundColor = Paint()
    ..strokeWidth = 12
    ..color = primary
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;
  static const Color primary =Color(0xff009688);
  static const Color primarySoft = Color(0xff66c0b8);
  static const Color secondary = Color(0xff009688);
  static const Color yellow = Color.fromARGB(214, 255, 196, 0);
  static const Color orange = Colors.orange;
  static const Color blue = Colors.blue;
  static const Color danger = Color(0xffb00020);
  static const Color error = Color(0xffb00020);
  static const Color warning = Color.fromARGB(255, 230, 185, 37);
  static const Color info = Color.fromARGB(255, 8, 171, 235);
  static const Color success = Color.fromARGB(179, 12, 187, 50);

  static MaterialColor constred = MaterialColor(
    _redPrimaryValue,
    <int, Color>{
      50: primary.withAlpha(50),
      100: primary.withAlpha(100),
      200: primary.withAlpha(200),
      300: primary.withAlpha(300),
      400: primary.withAlpha(400),
      500: primary.withAlpha(500),
      600: primary.withAlpha(600),
      700: primary.withAlpha(700),
      800: primary.withAlpha(800),
      900: primary.withAlpha(900),
    },
  );
  static const int _redPrimaryValue = 0xFFF44336;
  static const Color white = Colors.white;
  static const Color white50 = Color(0x88ffffff);
  static const Color grayDark = Color(0xffeaeaea);
  static const Color grey = Colors.grey;
  static const Color text = Color(0xff000000);
  static const Color text50 = Color(0x88000000);
  static const Color black = Colors.black;
  static const Color black50 = Color(0x88001424);
  static const Color blackLight = Color.fromARGB(255, 30, 33, 36);
}
