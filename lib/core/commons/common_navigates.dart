import 'package:flutter/cupertino.dart';
import 'package:raoxe/pages/forgot_password/forgot_password_page.dart';
import 'package:raoxe/pages/login/login_page.dart';
import 'package:raoxe/pages/register/register_page.dart';

class CommonNavigates {
  static Future toLoginPage(BuildContext context) async {
    return await Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => const LoginPage()));
  }

  static Future toRegisterPage(BuildContext context) async {
    return await Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => const RegisterPage()));
  }

  static Future toForgotPasswordPage(BuildContext context) async {
    return await Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => const ForgotPasswordPage()));
  }
}
