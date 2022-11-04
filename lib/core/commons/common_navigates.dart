// ignore_for_file: null_check_always_fails

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymystore/core/components/dialogs/confirm_otp_email.dialog.dart';
import 'package:mymystore/core/components/dialogs/confirm_otp_phone.dialog.dart';
import 'package:mymystore/screens/cart/cart_screen.dart';
import 'package:mymystore/screens/complete_profile/complete_profile_screen.dart';
import 'package:mymystore/screens/details/details_screen.dart';
import 'package:mymystore/screens/forgot_password/forgot_password_screen.dart';
import 'package:mymystore/screens/home/home_screen.dart';
import 'package:mymystore/screens/login_success/login_success_screen.dart';
import 'package:mymystore/screens/otp/otp_screen.dart';
import 'package:mymystore/screens/profile/profile_screen.dart';
import 'package:mymystore/screens/sign_in/sign_in_screen.dart';
import 'package:mymystore/screens/sign_up/sign_up_screen.dart';
import 'package:mymystore/screens/splash/splash_screen.dart';

class CommonNavigates {
  static Map<String, Widget Function(BuildContext)> routers =
      <String, WidgetBuilder>{
    SplashScreen.routeName: (context) => SplashScreen(),
    SignInScreen.routeName: (context) => SignInScreen(),
    ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
    LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
    SignUpScreen.routeName: (context) => SignUpScreen(),
    CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
    OtpScreen.routeName: (context) => OtpScreen(),
    HomeScreen.routeName: (context) => HomeScreen(),
    DetailsScreen.routeName: (context) => DetailsScreen(),
    CartScreen.routeName: (context) => CartScreen(),
    ProfileScreen.routeName: (context) => ProfileScreen(),
  };

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
