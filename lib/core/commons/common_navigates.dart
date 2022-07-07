// ignore_for_file: null_check_always_fails

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/core/components/dialogs/confirm_otp.dialog.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/pages/rao/advert/advert_detail_page.dart';
import 'package:raoxe/pages/rao/advert/advert_page.dart';
import 'package:raoxe/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:raoxe/pages/auth/login/login_page.dart';
import 'package:raoxe/pages/auth/register/register_page.dart';
import 'package:raoxe/pages/main/index.dart';
import 'package:raoxe/pages/main/news/news_detail_page.dart';
import 'package:raoxe/pages/rao/contact/contact_detail_page.dart';
import 'package:raoxe/pages/rao/contact/contact_page.dart';
import 'package:raoxe/pages/rao/my_product/my_product_detail_page.dart';
import 'package:raoxe/pages/rao/my_product/my_product_page.dart';
import 'package:raoxe/pages/product/product_detail_page.dart';
import 'package:raoxe/pages/product/product_page.dart';
import 'package:raoxe/pages/setting/settings_page.dart';
import 'package:raoxe/pages/user/user_page.dart';

class CommonNavigates {
  static Map<String, Widget Function(BuildContext)> routers =
      <String, WidgetBuilder>{
    // '/': (context) => const MyPage(),
    '/login': (context) => const LoginPage(),
    '/register': (context) => const RegisterPage(),
    '/forgot-password': (context) => const ForgotPasswordPage(),
    '/user': (context) => const UserPage(),
    '/settings': (context) => const SettingsPage(),
    '/product': (context) => ProductPage(),
    '/my-product': (context) => const MyProductPage(),
    '/advert': (context) => const AdvertPage(),
    '/news': (context) => const NewsPage(),
    '/contact': (context) => const ContactPage(),

    // '/search': (context) => SearchPage(),
  };

  static Future toProductPage(BuildContext context,
      {int? id, ProductModel? item, Map<String, dynamic>? paramsSearch}) async {
    if ((id != null && id > 0) || item != null) {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ProductDetailPage(id: id, item: item)));
    } else {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ProductPage(paramsSearch: paramsSearch)));
      // return await Navigator.pushNamed(context, "/product");
    }
  }

  static Future toMyProductPage(BuildContext context,
      {int? id, ProductModel? item, void Function(ProductModel)? onChanged}) async {
    if ((id != null && id > 0) || item != null) {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => MyProductDetailPage(id: id, item: item, onChanged: onChanged)));
    } else {
      return await Navigator.pushNamed(context, "/my-product");
    }
  }

  static Future toContactPage(BuildContext context,
      {int? id, ContactModel? item, void Function(ContactModel)? onChanged}) async {
    if ((id != null && id > 0) || item != null) {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ContactDetailPage(id: id, item: item, onChanged: onChanged)));
    } else {
      return await Navigator.pushNamed(context, "/contact");
    }
  }

  static Future toAdvertPage(BuildContext context,
      {int? id, AdvertModel? item}) async {
    if (id != null && id > 0) {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => AdvertDetailPage(id: id, item: item)));
    } else {
      return await Navigator.pushNamed(context, "/advert");
    }
  }

  static Future toNewsPage(BuildContext context,
      {int? id, NewsModel? item}) async {
    if ((id != null && id > 0) || item != null) {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => NewsDetailPage(id: id, item: item)));
    } else {
      return await Navigator.pushNamed(context, "/news");
    }
  }

  static Future toLoginPage(BuildContext context,
      {bool isReplace = true}) async {
    if (isReplace) {
      return await Navigator.pushReplacementNamed(context, "/login");
    }

    return await Navigator.pushNamed(context, "/login");
  }

  static Future toRegisterPage(BuildContext context) async {
    return await Navigator.pushNamed(context, "/register");
  }

  static Future toForgotPasswordPage(BuildContext context) async {
    return await Navigator.pushNamed(context, "/forgot-password");
  }

  static pop(BuildContext context, Object? value) {
    return Navigator.of(context).pop(value);
  }

  static Future toSettingsPage(BuildContext context) async {
    return await Navigator.pushNamed(context, "/settings");
  }

  static Future toUserPage(BuildContext context) async {
    return await Navigator.pushNamed(context, "/user");
  }

  static goBack(BuildContext context, [dynamic? result]) {
    if (result != null) {
      return Navigator.pop(context, result);
    } else {
      return Navigator.pop(context);
    }
  }

  static exit(BuildContext context) {
    return SystemNavigator.pop();
  }

  static Future openDialog(BuildContext context, Widget child) async {
    return await Navigator.of(context).push(MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return child;
        },
        fullscreenDialog: true));
  }

   static Future openOtpVerificationDialog(BuildContext context, String phone, bool isExist) async {
    return await Navigator.of(context).push(MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return OtpVerificationDialog(phone: phone, isExist: isExist);
        }));
  }

  static Future openSelect(BuildContext context, Widget child,
      {double? height}) async {
    return showDialogBottomSheet(context, child);
  }

  static Future showDialogBottomSheet(BuildContext context, Widget child,
      {double height = 0.95}) async {
    return showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            height: height,
            child: child,
          );
        });
  }
}
