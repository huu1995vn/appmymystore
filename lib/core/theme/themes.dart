import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymystore/core/utilities/app_colors.dart';

class Themes {
  static ThemeData _theme({bool isDark = false}) {
    return isDark ? _dark() : _light();
  }

  static ThemeData _light() {
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: const Color(0xfafafa),
      cardColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(size: 19, color: AppColors.white),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary, foregroundColor: AppColors.white),
      iconTheme: const IconThemeData(size: 19, color: AppColors.white),
      
    );
  }

  static ThemeData _dark() {
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(size: 19, color: AppColors.white),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary, foregroundColor: AppColors.white),
      iconTheme: const IconThemeData(size: 19, color: AppColors.white),

      // primaryColor: AppColors.black,
      // scaffoldBackgroundColor: Color(0x616161),
      // cardColor: isDark ? AppColors.blackLight : AppColors.white,
      // dividerColor: isDark
      //     ? AppColors.white.withOpacity(0.2)
      //     : AppColors.black.withOpacity(0.1),
      // shadowColor: isDark ? AppColors.text : AppColors.grayDark,
      // primarySwatch: _getMaterialColorFromColor(primaryColor),
      // textTheme: GoogleFonts.robotoTextTheme(
      //     ThemeData(brightness: isDark ? Brightness.dark : Brightness.light)
      //         .textTheme
      //         .copyWith(
      //           bodyLarge: const TextStyle(fontSize: 13.0),
      //           bodyMedium: const TextStyle(fontSize: 10.0),
      //           bodySmall: const TextStyle(fontSize: 8.0),
      //           labelLarge: const TextStyle(fontSize: 13.0),
      //         )),
      // iconTheme: const IconThemeData(size: 19, color: AppColors.white),
      // cardTheme: const CardTheme(
      //   margin: EdgeInsets.zero,
      //   shape: Border(),
      //   shadowColor: Colors.transparent,
      //   elevation: 0,
      // ),
      // appBarTheme: AppBarTheme(
      //     elevation: 0,
      //     iconTheme: const IconThemeData(
      //       color: AppColors.white,
      //     ),
      //     backgroundColor: isDark ? primaryColorDarkMode : primaryColor,
      //     systemOverlayStyle: SystemUiOverlayStyle.light),
    );
  }

  static Color _getShade(Color color,
      {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static MaterialColor _getMaterialColorFromColor(Color color) {
    Map<int, Color> colorShades = {
      50: _getShade(color, value: 0.5),
      100: _getShade(color, value: 0.4),
      200: _getShade(color, value: 0.3),
      300: _getShade(color, value: 0.2),
      400: _getShade(color, value: 0.1),
      500: color, //Primary value
      600: _getShade(color, value: 0.1, darker: true),
      700: _getShade(color, value: 0.15, darker: true),
      800: _getShade(color, value: 0.2, darker: true),
      900: _getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }

  static Color primaryColor = AppColors.primary;
  static Color primaryColorDarkMode = AppColors.blackLight;
  static ThemeData lightTheme = _theme();
  static ThemeData darkTheme = _theme(isDark: true);
}
