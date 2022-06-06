import 'package:flutter/cupertino.dart';
import 'package:raoxe/pages/forgot_password/forgot_password_page.dart';
import 'package:raoxe/pages/login/login_page.dart';
import 'package:raoxe/pages/register/register_page.dart';
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
    '/setting': (context) => const SettingsPage(),
  };
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
}
