// ignore_for_file: null_check_always_fails

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:raoxe/pages/auth/login/login_page.dart';
import 'package:raoxe/pages/auth/register/register_page.dart';
import 'package:raoxe/pages/main/index.dart';
import 'package:raoxe/pages/main/news/news_detail_page.dart';
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
    '/product': (context) => const ProductPage(),
    '/news': (context) => const NewsPage(),
  };

  static Future toProductPage(BuildContext context, int parse,
      {int? id}) async {
    if (id != null && id > 0) {
      return await Navigator.push(context,
          CupertinoPageRoute(builder: (context) => ProductDetailPage(id: id)));
    } else {
      return await Navigator.pushReplacementNamed(context, "/product");
    }
  }

  static Future toNewsPage(BuildContext context, {int? id, NewsModel? data}) async {
    if ((id != null && id > 0) || data!=null) {
      return await Navigator.push(context,
          CupertinoPageRoute(builder: (context) => NewsDetailPage(id: id, news: data)));
    } else {
      return await Navigator.pushReplacementNamed(context, "/news");
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
    return await Navigator.pushReplacementNamed(context, "/register");
  }

  static Future toForgotPasswordPage(BuildContext context) async {
    return await Navigator.pushReplacementNamed(context, "/forgot-password");
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

  static goBack(BuildContext context) {
    return Navigator.pop(context);
  }

  static exit(BuildContext context) {
    return SystemNavigator.pop();
  }
}
