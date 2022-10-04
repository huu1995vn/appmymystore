import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class Themes {
  static Color primaryColor = AppColors.primary;
  static Color primaryColorDarkMode = AppColors.blackLight;
  static ThemeData lightTheme = ThemeData.light().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: AppColors.grey,
    cardColor: AppColors.white,
    dividerColor: AppColors.black.withOpacity(0.1),
    shadowColor: AppColors.grayDark,
    
    // textTheme: GoogleFonts.latoTextTheme(ThemeData(brightness:  Brightness.light).textTheme.copyWith(
    //       bodyLarge: const TextStyle(fontSize: 16.0),
    //       bodyMedium: const TextStyle(fontSize: 13.0),
    //       labelLarge: const TextStyle(fontSize: 16.0),
    //     )),
    iconTheme: const IconThemeData(size: 19, color: AppColors.white),
    appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
    ),
    // brightness: Brightness.dark,
    // primaryColor: AppColors.white,
    // scaffoldBackgroundColor: Colors.black,
    // cardColor: AppColors.blackLight,
    // dividerColor: AppColors.white.withOpacity(0.2),
    // shadowColor: AppColors.text,
    textTheme: GoogleFonts.latoTextTheme(ThemeData(brightness: Brightness.dark).textTheme.copyWith(
          bodyLarge: const TextStyle(fontSize: 16.0, color: AppColors.black),
          bodyMedium: const TextStyle(fontSize: 13.0, color: AppColors.black),
          labelLarge: const TextStyle(fontSize: 16.0, color: AppColors.black),
        )),
    iconTheme: const IconThemeData(size: 19),
    appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
        backgroundColor: primaryColorDarkMode,
        systemOverlayStyle: SystemUiOverlayStyle.light),
  );
  // static Color getShade(Color color, {bool darker = false, double value = .1}) {
  //   assert(value >= 0 && value <= 1);

  //   final hsl = HSLColor.fromColor(color);
  //   final hslDark = hsl.withLightness(
  //       (darker ? (hsl.lightness - value) : (hsl.lightness + value))
  //           .clamp(0.0, 1.0));

  //   return hslDark.toColor();
  // }

  // static MaterialColor getMaterialColorFromColor(Color color) {
  //   Map<int, Color> colorShades = {
  //     50: getShade(color, value: 0.5),
  //     100: getShade(color, value: 0.4),
  //     200: getShade(color, value: 0.3),
  //     300: getShade(color, value: 0.2),
  //     400: getShade(color, value: 0.1),
  //     500: color, //Primary value
  //     600: getShade(color, value: 0.1, darker: true),
  //     700: getShade(color, value: 0.15, darker: true),
  //     800: getShade(color, value: 0.2, darker: true),
  //     900: getShade(color, value: 0.25, darker: true),
  //   };
  //   return MaterialColor(color.value, colorShades);
  // }
}
