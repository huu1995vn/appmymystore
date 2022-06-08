import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/pages/my_page.dart';

class AuthService {
  static login(context, String username, String password) async {
    CommonMethods.lockScreen();
    try {
      var res = await DaiLyXeApiBLL_APIRaoXe().login(username, password);
      if (res.status > 0) {
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

  static autologin(context) async {
    var res = await DaiLyXeApiBLL_APIRaoXe().autologin();
    if (res.status > 0) {
      APITokenService.loginByData(res.data);
      if (!APITokenService.isValid) {
        CommonNavigates.toLoginPage(context, isReplace: true);
      }
    } else {
      CommonMethods.showToast(res.message);
    }
  }

  static logout(context) async {
    APITokenService.logout();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const MyPage(indexTab: 3)),
        (Route<dynamic> route) => route.isFirst);
  }
}
