import 'dart:convert';

import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/services/aes.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class APITokenService {
  static String _token = "";
  static dynamic userId;
  static bool isExpired = false;
  static bool isValid = false;
  static String fullname = "";
  static int fileId = -1;

  static String get _getTokenDefaultString {
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
    if (_token.isNotNullEmpty) {
      return _token;
    } else {
      return _getTokenDefaultString;
    }
  }

  static set token(String pToken) {
    _token = pToken;
    isValid = false;
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

  static bool loginByData(String pData) {
    try {
      StorageService.set(StorageKeys.dataLogin, pData);
      String dataBase64 = convertBase64FromUrl(pData);
      Map data = json.decode(AESService.decrypt(dataBase64));
      if ((data["token"] as String).isNotNullEmpty) {
        token = data["token"];
        fullname = data["fullname"];
        fileId = int.parse(data["img"] ?? "0");
        return true;
      }
      // ignore: empty_catches
    } catch (e) {}

    return false;
  }

  static void init() {
    try {
      String pData = StorageService.get(StorageKeys.dataLogin);
      if (pData.isNotNullEmpty) {
        loginByData(pData);
      }
    } catch (e) {}
  }
}
