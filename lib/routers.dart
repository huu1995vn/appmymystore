import 'package:flutter/material.dart';
import 'package:raoxe/pages/forgot_password/forgot_password_page.dart';
import 'package:raoxe/pages/login/login_page.dart';
// import 'package:raoxe/pages/my_page.dart';
import 'package:raoxe/pages/register/register_page.dart';

Map<String, Widget Function(BuildContext)> myRouters = <String, WidgetBuilder>{
  // '/': (context) => const MyPage(),
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),
  '/forgot-password': (context) => const ForgotPasswordPage(),
};
