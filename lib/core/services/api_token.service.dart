// ignore_for_file: empty_catches, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/services/aes.service.dart';
import 'package:mymystore/core/services/firebase/firebase_messaging_service.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:mymystore/core/utilities/constants.dart';
import 'package:mymystore/core/utilities/extensions.dart';

class APITokenService {
  static String _token = "";
  static int userId = -1;
  static bool isExpired = false;
  static bool isValid = false;

  static String get getTokenDefaultString {
    String token = "";
    try {
      int expired = DateTime.now().add(const Duration(days: 1)).ticks;
      String value = "-1|${expired.toString()}";
      String code = CommonMethods.generateMd5("$value$TOKEN_SECURITY_KEY");
      String resAes = AESService.encrypt("$value.$code");
      token = convertUrlFromBase64(resAes);
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
    return token;
  }

  static String get token {
    return _token;
  }

  static set token(String pToken) {
    _token = pToken;
    isValid = false;
    isExpired = false;
    userId = -1;

    if (pToken.isNotNullEmpty) {
      try {
        dynamic tokenSplit =
            AESService.decrypt(convertBase64FromUrl(pToken)).split('.');
        if (CommonMethods.generateMd5(tokenSplit[0] + TOKEN_SECURITY_KEY) ==
            tokenSplit[1]) {
          dynamic values = tokenSplit[0].split('|');
          userId = int.parse(values[0]);
          isExpired = DateTime.now().ticks > int.parse(values[1]);
          isValid = true;
        }
      } catch (ex) {
        // throw new Exception(CommonConstants.MESSAGE_TOKEN_INVALID + string.Format(" ({0})", ex.Message));
      }
    }
  }

  static String convertBase64FromUrl(String pText) {
    String res = pText.replaceAll('_', '+').replaceAll('-', '/');
    switch (pText.length % 4) {
      case 2:
        res += "==";
        break;
      case 3:
        res += "=";
        break;
    }
    return res;
  }

  static String convertUrlFromBase64(String pText) {
    return pText.replaceAll('+', '_').replaceAll('/', '-').split("=")[0];
  }

  static Future<bool> login(String pData) async {
    bool res = false;
    try {
      String dataBase64 = convertBase64FromUrl(pData);
      Map data = json.decode(AESService.decrypt(dataBase64));
      if ((data["token"] as String).isNotNullEmpty) {
        token = data["token"];
        await StorageService.set(StorageKeys.dataLogin, pData);
        var topic = "user${APITokenService.userId}";
        FirebaseMessagingService.subscribeToTopic(topic);
        res = true;
      }
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }

    return res;
  }

  // static unsubscribeAlltopic(topic) {
  //   ApiBLL_APIUser().topics().then((value) {
  //     try {
  //       value.data["res"]["topics"].forEach((key, value) {
  //         if (topic == null || key != topic) {
  //           FirebaseMessagingService.unsubscribeFromTopic(key);
  //         }
  //       });
  //     } catch (e) {}
  //   });
  // }

  static Future<bool> logout() async {
    try {
      await FirebaseMessagingService.refeshToken();
      StorageService.deleteItem(StorageKeys.dataLogin);
      StorageService.listFavorite = [];
      token = "";
      return true;
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }

    return false;
  }

  static void init() {
    try {
      String pData = StorageService.get(StorageKeys.dataLogin);
      if (pData.isNotNullEmpty) {
        login(pData);
      }
    } catch (e) {}
  }
}
