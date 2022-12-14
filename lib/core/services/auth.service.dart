// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, empty_catches, no_leading_underscores_for_local_identifiers

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mymystore/core/api/api.bll.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/dialogs/password_auth.dailog.dart';
import 'package:mymystore/core/entities.dart';
// import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/firebase/firebase_auth.service.dart';
import 'package:mymystore/core/services/info_device.service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:mymystore/core/utilities/extensions.dart';
import 'package:mymystore/pages/home/home.page.dart';

class AuthService {
  static Future<bool> login(
      BuildContext context, String username, String password) async {
    CommonMethods.lockScreen();
    bool islogin = false;
    try {
      await InfoDeviceService.dataSafety();
      var res = await ApiBLL_APIToken().login(username, password);
      if (res.status > 0) {
        APITokenService.token = res.data;
        islogin = res.status > 0;
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
    CommonMethods.unlockScreen();

    return islogin;
  }

  static Future<bool> refreshlogin() async {
    if (APITokenService.token != null && APITokenService.token.isNotEmpty) {
      await InfoDeviceService.dataSafety();
      String token = StorageService.getTokenBiometric();
      var res = await ApiBLL_APIToken().refreshlogin(token);
      if (res.status > 0) {
        APITokenService.token = res.data;
      }
      return res.status == 1;
    }
    return false;
  }

  static Future logout(context) async {
    CommonMethods.lockScreen();
    try {
      APITokenService.token = "";
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()),
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

   static Future checkEmail(phone, {bool isExist = false}) async {
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

  static Future<bool> checkPermission(BuildContext context, String phone) async {
    
    String phonenumber = CommonMethods.formatPhoneNumber(phone);
    if (!CommonMethods.checkStringPhone(phonenumber)) {
      CommonMethods.showToast("invalid.phone".tr);
      return false;
    }
    bool valid = false;
    if (CommonConfig.IsBiometricSupported &&
        StorageService.getBiometric() != null) {
      valid = await AuthService.authBiometric();
    } else {
      phonenumber = await CommonNavigates.openDialog(
          context, PasswordAuthDialog(username: phonenumber));
      valid = phonenumber.isNotNullEmpty;
    }
    return valid;
  }
}