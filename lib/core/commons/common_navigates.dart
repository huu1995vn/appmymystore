// ignore_for_file: null_check_always_fails

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymystore/pages/auth/forgot_password/forgot_password.page.dart';
import 'package:mymystore/pages/auth/register/register.page.dart';
import 'package:mymystore/pages/home/home.page.dart';
import 'package:mymystore/pages/profile/profile.page.dart';
import 'package:mymystore/pages/setting/settings.page.dart';

class CommonNavigates {
  static Map<String, Widget Function(BuildContext)> routers =
      <String, WidgetBuilder>{
    HomePage.route(): (context) => const HomePage(title: '123'),
    ProfilePage.route(): (context) => const ProfilePage(),
    SettingsPage.route(): (context) => const SettingsPage(),
  };

  static Future toRootPage(BuildContext context) async {
    return Navigator.popUntil(context, (route) => route.isFirst);
  }

  static Future toLoginPage(BuildContext context,
      {bool isReplace = true}) async {
    if (isReplace) {
      return await Navigator.pushNamed(context, "/login");
    }

    return await Navigator.pushNamed(context, "/login");
  }

  static Future toRegisterPage(BuildContext context, String pphone) async {
    return await Navigator.push(
        context, CupertinoPageRoute(builder: (context) => RegisterPage(phone: pphone)));
  }

  static Future toForgotPasswordPage(BuildContext context, String pphone) async {
    return await Navigator.push(
        context, CupertinoPageRoute(builder: (context) => ForgotPasswordPage(phone: pphone)));
  }

  static pop(BuildContext context, Object? value) {
    return Navigator.of(context).pop(value);
  }

  static Future toSettingsPage(BuildContext context) async {
    return await Navigator.pushNamed(context, SettingsPage.route());
  }

  // static Future toUserPage(BuildContext context, {int? id}) async {
  //   if ((id != null && id > 0)) {
  //     return await Navigator.push(
  //         context, CupertinoPageRoute(builder: (context) => UserPage(id: id)));
  //   } else {
  //     return await Navigator.pushNamed(context, "/user");
  //   }
  // }

  static goBack(BuildContext context, [dynamic result]) {
    if (result != null) {
      return Navigator.pop(context, result);
    } else {
      return Navigator.pop(context);
    }
  }

  static exitApp(BuildContext context) {
    if (Platform.isAndroid) {
      return SystemNavigator.pop();
    } else if (Platform.isIOS) {
      return exit(0);
    }
  }

  static Future openDialog(BuildContext context, Widget child) async {
    return await Navigator.of(context).push(MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return child;
        },
        fullscreenDialog: true));
  }

  static Future openSelect(BuildContext context, Widget child,
      {double? height}) async {
    return showDialogBottomSheet(context, child);
  }

  static Future showDialogBottomSheet(BuildContext context, Widget child,
      {double height = 420}) async {
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
