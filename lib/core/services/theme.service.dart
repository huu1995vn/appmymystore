import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../commons/common_configs.dart';

class ThemeService {
  static ThemeData main({bool isDark = false}) {
    Color primaryColor = AppColors.primary;
    Color primaryColorDarkMode = AppColors.blackLight;
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: isDark ? AppColors.white : primaryColor,
      scaffoldBackgroundColor: isDark ? Colors.black : AppColors.grey,
      cardColor: isDark ? AppColors.blackLight : AppColors.white,
      dividerColor: isDark
          ? AppColors.white.withOpacity(0.2)
          : AppColors.black.withOpacity(0.1),
      shadowColor: isDark ? AppColors.text : AppColors.grayDark,
      primarySwatch: getMaterialColorFromColor(primaryColor),
      textTheme: GoogleFonts.latoTextTheme(
          ThemeData(brightness: isDark ? Brightness.dark : Brightness.light)
              .textTheme
              .copyWith(
                bodyText1: const TextStyle(fontSize: 16.0),
                bodyText2: const TextStyle(fontSize: 13.0),
                button: const TextStyle(fontSize: 13.0),
              )),
      iconTheme: const IconThemeData(size: 19, color: AppColors.white),
      appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: AppColors.white,
          ),
          backgroundColor: isDark ? primaryColorDarkMode : primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle.light),
    );
  }

  static List<AppTheme> appThemeOptions = [
    AppTheme(
      mode: ThemeMode.light,
      title: 'Light',
      icon: AppIcons.sun,
    ),
    AppTheme(
      mode: ThemeMode.dark,
      title: 'Dark',
      icon: AppIcons.sun,
    ),
  ];
  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color, //Primary value
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }
}
