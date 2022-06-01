import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/core/models/app_theme.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeService {
  static ThemeData main({bool isDark = false}) {
    Color primaryColor = AppColors.primary;
   
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: isDark ? AppColors.black : AppColors.gray,
      cardColor: isDark ? AppColors.blackLight : AppColors.white,
      dividerColor: isDark
          ? AppColors.white.withOpacity(0.2)
          : AppColors.black.withOpacity(0.1),
      shadowColor: isDark ? AppColors.text : AppColors.grayDark,
      primarySwatch: getMaterialColorFromColor(primaryColor),
      textTheme: GoogleFonts.latoTextTheme(
          ThemeData(brightness: isDark ? Brightness.dark : Brightness.light)
              .textTheme),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: primaryColor,
        systemOverlayStyle:
            isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
    );
  }

  static List<AppTheme> appThemeOptions = [
    AppTheme(
      mode: ThemeMode.light,
      title: 'Light',
      icon: Icons.brightness_5_rounded,
    ),
    AppTheme(
      mode: ThemeMode.dark,
      title: 'Dark',
      icon: Icons.brightness_2_rounded,
    ),
    // AppTheme(
    //   mode: ThemeMode.system,
    //   title: 'System',
    //   icon: Icons.brightness_4_rounded,
    // ),
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
    Map<int, Color> _colorShades = {
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
    return MaterialColor(color.value, _colorShades);
  }
}
