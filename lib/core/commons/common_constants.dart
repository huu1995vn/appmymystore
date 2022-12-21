// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/utilities/app_colors.dart';

class CommonConstants {
  static const String kIconPath = 'assets/icons';
  static const kStepPrice = 20000000;
  static const TOKEN_SECURITY_KEY =
      "SDGD\$E^&Ư#RBSDGFGJ*IY^&ÉDQQWRWF#\$%#SGSAS";
  static const kPrimaryColor = Color.fromARGB(120, 8, 204, 106);
  static const kWhite = Colors.white;
  static const kTextColor = Color(0xFF707070);
  static const kTextLightColor = Color(0xFF949098);
  static const kDefaultPadding = 10.0;
  static const kDefaultRadius = 10.0;
  static const kDefaultMargin = 5.0;
  static const kDefaultPaddingTop = kDefaultPadding * 4;
  static const kItemOnPage = 10;
  static const kMaxImages = 15;
  static const kSizeHeight = 39.0;
  static const kSizeAvatarSmall = 30.0;
  static const kSizeAvatarMedium = 60.0;
  static const kSizeAvatarLarge = 120.0;
  static const kEdgeInsetsCardPadding = EdgeInsets.only(
      left: CommonConstants.kDefaultPadding,
      right: CommonConstants.kDefaultPadding);
  static const kEdgeInsetsPadding = EdgeInsets.only(
      left: CommonConstants.kDefaultPadding,
      right: CommonConstants.kDefaultPadding,
      top: CommonConstants.kDefaultPadding / 2,
      bottom: CommonConstants.kDefaultPadding / 2);
  static BoxDecoration kBoxDecorationStyle = BoxDecoration(
      gradient: LinearGradient(colors: [
    AppColors.primary,
    AppColors.primary.withAlpha(700),
    AppColors.primary.withAlpha(500),
    AppColors.primary
  ]));
  static const TextStyle kTextHeaderStyle = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle kTextTitleStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle kTextSubTitleStyle =
      TextStyle(fontWeight: FontWeight.normal, fontSize: 12);
  static const kTextPriceStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.primary,
  );
  static String MESSAGE_SUCCESS = "success".tr;
  static const MESSAGE_ERROR_404 = "Thao tác không tồn tại";
  static const MESSAGE_ERROR = "Thao tác thất bại";
  static const MESSAGE_ERROR_EMPTY = "Dữ liệu không được bỏ trống";
  static const MESSAGE_ERROR_INVALId = "Dữ liệu không hợp lệ";

  static const kTextTimeStyle = TextStyle(fontSize: 14);
  static const IMAGE_NO = "assets/images/no-image.png";
// static const NOIMAGEAVAILABELFOLDER = "/resources/Images/hinh-anh-khong-ton-tai/";
// static const NOIMAGEUUDAI = "assets/images/gift.png";
  static const IMAGE_NOUSER = "assets/images/avatar.png";
// static const LAZYLOADIMAGE = "/assets/lazy-load-image.jpg";
// static const CHECKSUCCESSIMAGE = "/assets/check-verify.jpg";
// static const MAINTOPIMAGE = "assets/images/bg/main_top.png";
// static const LOGINBOTTOMIMAGE = "assets/images/bg/login_bottom.png";
// static const BGLOGINMEMBERIMAGE = "assets/images/img-screen/bg-login-member.png";
  static const IMAGE_LOGO = "assets/images/logo.png";
// static const LOGORAOXEWHITEIMAGE = "assets/images/logo-mymystore-trang.png";
// static const UUDAISVG = "assets/images/img-screen/uu-dai.svg";
// static const BGBANNER = "assets/images/bg/bg-banner.png";
// static const NOTFOUNDDATA = "assets/images/img-screen/no-data.png";
  static const IMAGE_EMPTY = "assets/images/empty-data.png";
// static const BGOTP = "assets/images/img-screen/otp.png";
// static const ICON = "assets/icon.png";

  static const String IMAGE_NOT_FOUND =
      "https://cdn.gianhangvn.com/image/hinh-anh-khong-ton-tai.jpg";
  static const List<String> kBanners = ["84748", "84749", "84750"];

  static const List PRICES = [
    {"name": "0 - 500 triệu", "id": 0},
    {"name": "500 - 1 tỷ", "id": 1},
    {"name": "1tỷ - 5tỷ", "id": 2},
    {"name": "hơn 5tỷ", "id": 3}
  ];

  static List SORTS = [
    {"name": "latest".tr, "id": "VerifyDate DESC"},
    {"name": "oldest".tr, "id": "VerifyDate ASC"},
    {"name": "highpricefirst".tr, "id": "Price DESC"},
    {"name": "lowpricefirst".tr, "id": "Price ASC"}
  ];
  static List PRODUCTTYPES = [
    {"name": "sell".tr, "id": 1},
    {"name": "buy".tr, "id": 2},
  ];
  static List PRODUCTSTATES = [
    {"name": "new".tr, "id": 1},
    {"name": "old".tr, "id": 2},
  ];

  static List PRODUCTDOORS = [
    {"name": "2 ${"txtdoor".tr.toLowerCase()}", "id": 2},
    {"name": "4 ${"txtdoor".tr.toLowerCase()}", "id": 4},
  ];

  static List PRODUCTSEATS = [
    {"name": "2 ${"txtseat".tr.toLowerCase()}", "id": 2},
    {"name": "4 ${"txtseat".tr.toLowerCase()}", "id": 4},
    {"name": "5 ${"txtseat".tr.toLowerCase()}", "id": 5},
    {"name": "6 ${"txtseat".tr.toLowerCase()}", "id": 6},
    {"name": "7 ${"txtseat".tr.toLowerCase()}", "id": 7},
    {"name": "8 ${"txtseat".tr.toLowerCase()}", "id": 8},
    {"name": "9 ${"txtseat".tr.toLowerCase()}", "id": 9},
    {"name": "15 ${"txtseat".tr.toLowerCase()}", "id": 15},
    {"name": "16 ${"txtseat".tr.toLowerCase()}", "id": 16},
  ];
}

class MMParttern {
  //[Update]
  static String password =
      r'^(?=.*?[A-Z]).{8,25}$'; // Phải có ít nhất 1 ký tự chữ hoa
  static String phone = r"^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$";
  static String email =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
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

enum ViewType { grid, list }
