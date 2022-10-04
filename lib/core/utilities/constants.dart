// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

const kStepPrice = 20000000;
const TOKEN_SECURITY_KEY = "SDGD\$E^&Ư#RBSDGFGJ*IY^&ÉDQQWRWF#\$%#SGSAS";
const kPrimaryColor = Color.fromRGBO(182, 40, 49, 1);
const kWhite = Colors.white;
const kTextColor = Color(0xFF707070);
const kTextLightColor = Color(0xFF949098);
const kDefaultPadding = 10.0;
const kDefaultPaddingTop = 79.0;
const kItemOnPage = 10;
const kMaxImages = 15;
const kSizeHeight = 39.0;
const kEdgeInsetsCardPadding =
    EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding);
const kEdgeInsetsPadding = EdgeInsets.only(
    left: kDefaultPadding,
    right: kDefaultPadding,
    top: kDefaultPadding / 2,
    bottom: kDefaultPadding / 2);
const kBoxDecorationStyle = BoxDecoration(
    gradient: LinearGradient(colors: [
  AppColors.primary,
  AppColors.primary700,
  AppColors.primary500,
  AppColors.primary
]));
const TextStyle kTextHeaderStyle = TextStyle(
  fontSize: 19,
  fontWeight: FontWeight.bold,
);
const TextStyle kTextTitleStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.normal,
);
const TextStyle kTextSubTitleStyle = TextStyle(
    fontWeight: FontWeight.normal, 
    fontStyle: FontStyle.italic,
    fontSize: 14);
const kTextPriceStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: AppColors.primary,
);
const kTextTimeStyle = TextStyle(fontSize: 14, fontStyle: FontStyle.italic);
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
const EMPTYDATA = "assets/images/img-screen/empty-data.png";
const BGOTP = "assets/images/img-screen/otp.png";
const ICON = "assets/icon.png";

const String IMAGE_NOT_FOUND =
    "https://cdn.gianhangvn.com/image/hinh-anh-khong-ton-tai.jpg";
const List<String> kBanners = ["84748", "84749", "84750"];
List<Categorie> CATEGORIES = [
  Categorie(id: 2, categoryname: "news.new".tr),
  Categorie(id: 8, categoryname: "highlight".tr),
  Categorie(id: 3, categoryname: "vehicle.reviews".tr),
  Categorie(id: 4, categoryname: "advise".tr),
  Categorie(id: 5, categoryname: "image".tr),
];
List<Categorie> PRODUCTSTATUS = [
  Categorie(id: 1, categoryname: "pending".tr),
  Categorie(id: 2, categoryname: "approved".tr),
  Categorie(id: 3, categoryname: "not.approved".tr),
  Categorie(id: 4, categoryname: "violate".tr),
  // Categorie(id: 6, categoryname: "Videos"),
];

List<Categorie> PRODUCTREVIEWSTATUS = [
  Categorie(id: 1, categoryname: "approved".tr),
  Categorie(id: 2, categoryname: "not.approved".tr),
];

List PRICES = [
  {"name": "0 - 500 triệu", "id": 0},
  {"name": "500 - 1 tỷ", "id": 1},
  {"name": "1tỷ - 5tỷ", "id": 2},
  {"name": "hơn 5tỷ", "id": 3}
];

List SORTS = [
  {"name": "latest".tr, "id": "CreateDate DESC"},
  {"name": "oldest".tr, "id": "CreateDate ASC"},
  {"name": "highpricefirst".tr, "id": "Price DESC"},
  {"name": "lowpricefirst".tr, "id": "Price ASC"}
];
List PRODUCTTYPES = [
  {"name": "sell".tr, "id": 1},
  {"name": "buy".tr, "id": 2},
];
List PRODUCTSTATES = [
  {"name": "new".tr, "id": 1},
  {"name": "old".tr, "id": 2},
];

List PRODUCTDOORS = [
  {"name": "2 ${"seat".tr}", "id": 2},
  {"name": "4 ${"seat".tr}", "id": 4},
];

List PRODUCTSEATS = [
  {"name": "1 ${"door".tr}", "id": 1},
  {"name": "2 ${"door".tr}", "id": 2},
  {"name": "4 ${"door".tr}", "id": 4},
  {"name": "5 ${"door".tr}", "id": 5},
  {"name": "6 ${"door".tr}", "id": 6},
  {"name": "7 ${"door".tr}", "id": 7},
  {"name": "9 ${"door".tr}", "id": 9},
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

class NAMEFIREBASEDATABASE {
  static String configs = "configs";
  static String users = "users";
  static String devices = "devices";
}
