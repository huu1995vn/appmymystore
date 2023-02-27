// ignore_for_file: null_check_always_fails

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/pages/auth/forgot_password/forgot_password.page.dart';
import 'package:mymystore/pages/auth/register/register.page.dart';
import 'package:mymystore/pages/export/export_detail_page.dart';
import 'package:mymystore/pages/export/export_page.dart';
import 'package:mymystore/pages/home/home.page.dart';
import 'package:mymystore/pages/import/import_detail_page.dart';
import 'package:mymystore/pages/import/import_page.dart';
import 'package:mymystore/pages/product/product_detail_page.dart';
import 'package:mymystore/pages/product/product_page.dart';
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
    return await Navigator.push(context,
        CupertinoPageRoute(builder: (context) => RegisterPage(phone: pphone)));
  }

  static Future toForgotPasswordPage(
      BuildContext context, String pphone) async {
    return await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ForgotPasswordPage(phone: pphone)));
  }

  static Future toProductPage(BuildContext context,
      {int? id, ProductModel? item, Map<String, dynamic>? paramsSearch}) async {
    if ((id != null && id > 0) || item != null) {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  ProductDetailPage(key: UniqueKey(), id: id, item: item)));
    } else {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ProductPage(key: UniqueKey())));
      // return await Navigator.pushNamed(context, "/product");
    }
  }

  static Future toImportPage(BuildContext context,
      {int? id, ImportModel? item, Map<String, dynamic>? paramsSearch}) async {
    if ((id != null && id > 0) || item != null) {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  ImportDetailPage(key: UniqueKey(), id: id, item: item)));
    } else {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ImportPage(key: UniqueKey())));
      // return await Navigator.pushNamed(context, "/product");
    }
  }

  
  static Future toExportPage(BuildContext context,
      {int? id, ExportModel? item, Map<String, dynamic>? paramsSearch}) async {
    if ((id != null && id > 0) || item != null) {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  ExportDetailPage(key: UniqueKey(), id: id, item: item)));
    } else {
      return await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ExportPage(key: UniqueKey())));
      // return await Navigator.pushNamed(context, "/product");
    }
  }


  static pop(BuildContext context, Object? value) {
    return Navigator.of(context).pop(value);
  }

  static Future toSettingsPage(BuildContext context) async {
    return await Navigator.pushNamed(context, SettingsPage.route());
  }

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
