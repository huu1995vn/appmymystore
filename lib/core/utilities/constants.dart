// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

const kStepPrice = 20000000;
const TOKEN_SECURITY_KEY = "SDGD\$E^&Ư#RBSDGFGJ*IY^&ÉDQQWRWF#\$%#SGSAS";
const kPrimaryColor = Color(0xFFFF1031);
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
    color: AppColors.black50,
    fontSize: 12);
const kTextPriceStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: AppColors.primary,
);
const kTextTimeStyle = TextStyle(
    fontStyle: FontStyle.italic, color: AppColors.black50, fontSize: 12);
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
const String IMAGE_NOT_FOUND =
    "https://cdn.gianhangvn.com/image/hinh-anh-khong-ton-tai.jpg";
const List<String> kBanners = ["84748", "84749", "84750"];
List<Categorie> CATEGORIES = [
  Categorie(id: 2, categoryname: "Tin tức mới"),
  Categorie(id: 8, categoryname: "Nổi bật"),
  Categorie(id: 3, categoryname: "Đánh giá xe"),
  Categorie(id: 4, categoryname: "Tư vấn"),
  Categorie(id: 5, categoryname: "Hình ảnh"),
];
List<Categorie> PRODUCTSTATUS = [
  Categorie(id: 1, categoryname: "Chờ duyệt"),
  Categorie(id: 2, categoryname: "Đã duyệt"),
  Categorie(id: 3, categoryname: "Không duyệt"),
  Categorie(id: 4, categoryname: "Vi phạm"),
  // Categorie(id: 6, categoryname: "Videos"),
];

List<Categorie> PRODUCTREVIEWSTATUS = [
  Categorie(id: 1, categoryname: "Đã duyệt"),
  Categorie(id: 2, categoryname: "Không duyệt"),
];

List PRICES = [
  {"name": "0 - 500 triệu", "id": 0},
  {"name": "500 - 1 tỷ", "id": 1},
  {"name": "1tỷ - 5tỷ", "id": 2},
  {"name": "hơn 5tỷ", "id": 3}
];

List SORTS = [
  {"name": "Mới nhất", "id": "CreateDate DESC"},
  {"name": "Cũ nhất", "id": "CreateDate ASC"},
  {"name": "Giá cao trước", "id": "Price DESC"},
  {"name": "Giá thấp trước", "id": "Price ASC"}
];
List PRODUCTTYPES = [
  {"name": "Bán", "id": 1},
  {"name": "Mua", "id": 2},
];
List PRODUCTSTATES = [
  {"name": "Mới", "id": 1},
  {"name": "Đã sử dụng", "id": 2},
];

List PRODUCTDOORS = [
  {"name": "2 Cửa", "id": 2},
  {"name": "4 Cửa", "id": 4},
];

List PRODUCTSEATS = [
  {"name": "1 Chỗ", "id": 1},
  {"name": "2 Chỗ", "id": 2},
  {"name": "4 Chỗ", "id": 4},
  {"name": "5 Chỗ", "id": 5},
  {"name": "6 Chỗ", "id": 6},
  {"name": "7 Chỗ", "id": 7},
  {"name": "9 Chỗ", "id": 9},
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
}
