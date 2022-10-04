import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class Themes {
  
  final lightTheme = ThemeData.light().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
    ),
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.grey,
    cardColor: AppColors.white,
    dividerColor: AppColors.black.withOpacity(0.1),
    shadowColor: AppColors.grayDark,
    // primarySwatch: getMaterialColorFromColor(primaryColor),
    textTheme: GoogleFonts.latoTextTheme(
        ThemeData(brightness: Brightness.light).textTheme.copyWith(
              bodyText1: const TextStyle(fontSize: 16.0),
              bodyText2: const TextStyle(fontSize: 13.0),
              button: const TextStyle(fontSize: 13.0),
            )),
    iconTheme: const IconThemeData(size: 19, color: AppColors.blackLight),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primary,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
  );
  final darkTheme = ThemeData.dark().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
    ),
    brightness: Brightness.dark,
    primaryColor: AppColors.black,
    scaffoldBackgroundColor: Colors.black,
    cardColor: AppColors.blackLight,
    dividerColor: AppColors.white.withOpacity(0.2),
    shadowColor: AppColors.text,
    textTheme: GoogleFonts.latoTextTheme(
        ThemeData(brightness: Brightness.dark).textTheme.copyWith(
              bodyText1: const TextStyle(fontSize: 16.0),
              bodyText2: const TextStyle(fontSize: 13.0),
              button: const TextStyle(fontSize: 13.0),
            )),
    iconTheme: const IconThemeData(size: 19, color: AppColors.white),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primary,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
  );
}
