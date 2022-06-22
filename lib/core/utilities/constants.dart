// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

const TOKEN_SECURITY_KEY = "SDGD\$E^&Ư#RBSDGFGJ*IY^&ÉDQQWRWF#\$%#SGSAS";
const kPrimaryColor = Color(0xFFFF1031);
const kWhite = Colors.white;
const kTextColor = Color(0xFF707070);
const kTextLightColor = Color(0xFF949098);
const kDefaultPadding = 10.0;
const kDefaultPaddingTop = 79.0;
const kItemOnPage = 10;

const kBoxDecorationStyle = BoxDecoration(
    gradient: LinearGradient(colors: [
  AppColors.primary,
  AppColors.primary700,
  AppColors.primary500,
  AppColors.primary
]));
const kTextHeaderStyle = TextStyle(
  fontSize: 19,
  fontWeight: FontWeight.bold,
);
const kTextPriceStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: AppColors.primary,
);
const kTextTimeStyle = TextStyle(
  fontStyle: FontStyle.italic,
  color: AppColors.black50,
  fontSize: 12
);
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
const BGBANNER = "assets/images/bg/bg-banner.png";
const NOTFOUNDDATA = "assets/images/img-screen/no-data.png";
const BGOTP = "assets/images/img-screen/otp.png";
List<Categorie> CATEGORIES = [
  Categorie(id: 2, categoryname: "Tin tức mới"),
  Categorie(id: 8, categoryname: "Nổi bật"),
  Categorie(id: 3, categoryname: "Đánh giá xe"),
  Categorie(id: 4, categoryname: "Tư vấn"),
  Categorie(id: 5, categoryname: "Hình ảnh"),
  // Categorie(id: 6, categoryname: "Videos"),
];
List<Categorie> PRODUCTSTATUS = [
  Categorie(id: 1, categoryname: "Chờ duyệt"),
  Categorie(id: 2, categoryname: "Đã duyệt"),
  Categorie(id: 3, categoryname: "Không duyệt"),
  Categorie(id: 4, categoryname: "Vi phạm"),
  // Categorie(id: 6, categoryname: "Videos"),
];

class RxParttern {
  //[Update]
  static String password =
      r'^(?=.*?[A-Z]).{8,25}$'; // Phải có ít nhất 1 ký tự chữ hoa
  static String phone = r"^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$";
}

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
