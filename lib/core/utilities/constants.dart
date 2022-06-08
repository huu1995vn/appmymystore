// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/app_colors.dart';


const TOKEN_SECURITY_KEY = "SDGD\$E^&Ư#RBSDGFGJ*IY^&ÉDQQWRWF#\$%#SGSAS";
const kPrimaryColor = Color(0xFFFF1031);
const kWhite = Colors.white;
const kTextColor = Color(0xFF707070);
const kTextLightColor = Color(0xFF949098);
const kDefaultPadding = 10.0;
const kDefaultPaddingTop = 79.0;

const kBoxDecorationStyle = BoxDecoration(
    gradient: LinearGradient(colors: [
  AppColors.primary,
  AppColors.primary700,
  AppColors.primary500
]));

const NOIMAGE = "assets/images/no-image.jpg";
const NOIMAGEAVAILABELFOLDER = "/resources/Images/hinh-anh-khong-ton-tai/";
const NOIMAGEUUDAI = "assets/images/gift.png";
const NOIMAGEUSER = "assets/avatar.png";
const LAZYLOADIMAGE = "/assets/lazy-load-image.jpg";
const CHECKSUCCESSIMAGE = "/assets/check-verify.jpg";
const MAINTOPIMAGE = "assets/images/bg/main_top.png";
const LOGINBOTTOMIMAGE = "assets/images/bg/login_bottom.png";
const BGLOGINMEMBERIMAGE = "assets/images/img-screen/bg-login-member.png";
const LOGORAOXECOLORIMAGE = "assets/logo-raoxe-comau.png";
const LOGORAOXEWHITEIMAGE = "assets/images/logo-raoxe-trang.png";
const UUDAISVG = "assets/images/img-screen/uu-dai.svg";

abstract class FormStyle {
  // Màu nền form
  static dynamic colorBackground = Colors.grey[200];

  // Line style khi focus
  static dynamic focusedBorder = const OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: Colors.blue),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );

  static dynamic errorBorder = const OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: Colors.red),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );

  static dynamic border = const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );
  static String charRequire = "*";
}
