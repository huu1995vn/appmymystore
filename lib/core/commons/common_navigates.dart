// ignore_for_file: null_check_always_fails

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymystore/core/components/dialogs/confirm_otp_email.dialog.dart';
import 'package:mymystore/core/components/dialogs/confirm_otp_phone.dialog.dart';

class CommonNavigates {
  static Map<String, Widget Function(BuildContext)> routers =
      <String, WidgetBuilder>{
    // // '/': (context) => const MyPage(),
    // '/login': (context) => const LoginPage(),
    // '/register': (context) => const RegisterPage(),
    // '/forgot-password': (context) => const ForgotPasswordPage(),
    // '/user': (context) => const UserPage(),
    // '/settings': (context) => const SettingsPage(),
    // '/product': (context) => ProductPage(),
    // '/my-product': (context) => const MyProductPage(),
    // '/advert': (context) => const AdvertPage(),
    // '/vehiclecontact': (context) => const VehicleContactPage(),
    // '/news': (context) => const NewsPage(),
    // '/notification': (context) => const NotificationPage(),
    // '/contact': (context) => const ContactPage(),
    // '/review': (context) => const ReviewPage(),
    // '/favorite': (context) => const FavoritePage(),
    // '/point': (context) => const PointPage()
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

  static Future openOtpVerificationPhoneDialog(
      BuildContext context, String phone, bool isExist) async {
    return await Navigator.of(context)
        .push(MaterialPageRoute<dynamic>(builder: (BuildContext context) {
      return OtpVerificationPhoneDialog(phone: phone, isExist: isExist);
    }));
  }

  static Future openOtpVerificationEmailDialog(
      BuildContext context, String email) async {
    return await Navigator.of(context)
        .push(MaterialPageRoute<dynamic>(builder: (BuildContext context) {
      return OtpVerificationEmailDialog(email: email);
    }));
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
