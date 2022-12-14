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
import 'package:local_auth/local_auth.dart';
import 'package:mymystore/pages/home/home.dart';

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
      var res = await ApiBLL_APIToken().refreshlogin();
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
              builder: (BuildContext context) => const HomeScreen()),
          (Route<dynamic> route) => route.isFirst);
    } catch (e) {}
    CommonMethods.unlockScreen();
  }
}