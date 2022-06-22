// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
// import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/firebase/firebase_auth.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/pages/my_page.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  static Future login(
      BuildContext context, String username, String password) async {
    CommonMethods.lockScreen();
    try {
      var res = await DaiLyXeApiBLL_APIAuth().login(username, password);
      if (res.status > 0) {
        await StorageService.set(StorageKeys.userlogin,
          <String, String>{"username": username, "password": password});
        APITokenService.loginByData(res.data);
        if (APITokenService.isValid) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const MyPage(indexTab: 3)),
              (Route<dynamic> route) => route.isFirst);
        }
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {}
    CommonMethods.unlockScreen();
  }

  static Future<bool> autologin() async {
    if (APITokenService.token != null) {
      var res = await DaiLyXeApiBLL_APIAuth().autologin();
      if (res.status > 0) {
        APITokenService.loginByData(res.data);
      }
      return res.status==1;
    }
    return false;
  }

  static Future logout(context) async {
    APITokenService.logout();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const MyPage(indexTab: 3)),
        (Route<dynamic> route) => route.isFirst);
  }

  static Future checkPhone(phone, {bool isExist = false}) async {
    //isExist == false: dùng đăng ký hoặc thay đổi phone
    //isExist == true: dùng cho quên mật khẩu

    if (!CommonMethods.checkStringPhone(phone)) {
      throw "invalid.phone".tr();
    }
    var res = await DaiLyXeApiBLL_APIGets().statsuser({"phone": phone});
    int status = res.data;
    if (isExist) {
      if (status == -1) {
        throw "notexist.account".tr();
      }
    } else {
      if (status == 1) {
        throw "exist.account".tr();
      }
    }
    if (status >= 2) {
      throw "message.str014".tr();
    }
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

  static Future<bool> authBiometric() async {
    //initialize Local Authentication plugin.
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    //status of authentication.
    bool isAuthenticated = false;
    //check if device supports biometrics authentication.
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();
    //check if user has enabled biometrics.
    //check
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

    //if device supports biometrics and user has enabled biometrics, then authenticate.
    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
            localizedReason: 'Scan your fingerprint to authenticate',
            options: const AuthenticationOptions(
                biometricOnly: true, useErrorDialogs: true, stickyAuth: true));
      } on PlatformException catch (e) {
        CommonMethods.wirtePrint(e);
      }
    }
    return isAuthenticated;
  }
}
