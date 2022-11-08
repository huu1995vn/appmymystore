// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, empty_catches, no_leading_underscores_for_local_identifiers

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mymystore/core/api/api.bll.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/entities.dart';
// import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/firebase/firebase_auth.service.dart';
import 'package:mymystore/core/services/info_device.service.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mymystore/pages/home/home.dart';

class AuthService {
  static Future login(
      BuildContext context, String username, String password) async {
    CommonMethods.lockScreen();
    try {
      await InfoDeviceService.dataSafety();
      var res = await ApiBLL_APIAuth().login(username, password);
      if (res.status > 0) {
        await APITokenService.login(res.data);
        if (APITokenService.isValid) {
          await StorageService.set(StorageKeys.userlogin,
              <String, String>{"username": username, "password": password});

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomeScreen()),
              (Route<dynamic> route) => route.isFirst);
        }
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {}
    CommonMethods.unlockScreen();
  }

  static Future<bool> autologin() async {
    if (APITokenService.token != null && APITokenService.token.isNotEmpty) {
      await InfoDeviceService.dataSafety();
      var res = await ApiBLL_APIAuth().autologin();
      if (res.status > 0) {
        APITokenService.login(res.data);
      }
      return res.status == 1;
    }
    return false;
  }

  static Future logout(context) async {
    CommonMethods.lockScreen();
    try {
      await APITokenService.logout();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()),
          (Route<dynamic> route) => route.isFirst);
    } catch (e) {}
    CommonMethods.unlockScreen();
  }

  static Future checkPhone(phone, {bool isExist = false}) async {
    //isExist == false: dùng đăng ký hoặc thay đổi phone
    //isExist == true: dùng cho quên mật khẩu

    if (!CommonMethods.checkStringPhone(phone)) {
      throw "invalid.phone".tr;
    }
    var res = await ApiBLL_APIGets().statsuser({"phone": phone});
    int status = res.data;
    if (isExist) {
      if (status == -1) {
        throw "notexist.account".tr;
      }
    } else {
      if (status == 1) {
        throw "exist.account".tr;
      }
    }
    if (status >= 2) {
      throw "message.str002".tr;
    }
  }

  static checkEmail(email) {
    //isExist == false: dùng đăng ký hoặc thay đổi phone
    //isExist == true: dùng cho quên mật khẩu

    if (!CommonMethods.checkStringEmail(email)) {
      throw "invalid.email".tr;
    }
    // var res = await ApiBLL_APIGets().statsuser({"email": email});
    // int status = res.data;
    // if (isExist) {
    //   if (status == -1) {
    //     throw "notexist.account".tr;
    //   }
    // } else {
    //   if (status == 1) {
    //     throw "exist.account".tr;
    //   }
    // }
    // if (status >= 2) {
    //   throw "message.str002".tr;
    // }
  }

  static Future sendOTPPhone(String phone, bool isExist,
      void Function(Object) fnError, void Function() fnSuccess) async {
    try {
      await AuthService.checkPhone(phone, isExist: isExist);
      await FirebaseAuthService.sendOTP(phone, fnError, fnSuccess);
    } catch (e) {
      fnError(e);
    }
  }

  static Future<bool> verifyOTPPhone(String phone, String code) async {
    return await FirebaseAuthService.verifyOTP(phone, code);
  }

  static String verifyemail = "";
  static Future sendOTPEmail(String email, void Function(Object) fnError,
      void Function() fnSuccess) async {
    try {
      ResponseModel res = await ApiBLL_APIUser().sendverifyemail(email);
      if (res.status <= 0) {
        fnError(res.message);
      }
      verifyemail = res.data;
      fnSuccess();
    } catch (e) {
      fnError(e);
    }
  }

  static Future<bool> verifyOTPEmail(String code) async {
    ResponseModel res = await ApiBLL_APIUser().verifyemail(verifyemail, code);
    if (res.status <= 0) {
      throw Exception(res.message);
    }
    return res.status > 0;
  }

  static Future<bool> authBiometric() async {
    //initialize Local Authentication plugin.
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    //status of authentication.
    bool isAuthenticated = false;
    //check if device supports biometrics authentication.
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();
    if (!isBiometricSupported) {
      throw "message.str010".tr;
    }
    //check if user has enabled biometrics.
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    if (!canCheckBiometrics) {
      throw "message.str011".tr;
    }
    //if device supports biometrics and user has enabled biometrics, then authenticate.
    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
          options: const AuthenticationOptions(
              biometricOnly: true, useErrorDialogs: true, stickyAuth: true));
    }
    return isAuthenticated;
  }
}
