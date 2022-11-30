// ignore_for_file: empty_catches, non_constant_identifier_names

import 'dart:convert';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/services/auth.service.dart';
import 'package:mymystore/core/services/firebase/firebase_messaging_service.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:mymystore/core/utilities/extensions.dart';

class APITokenService {
  static String _token = "";
  static UserModel user = UserModel();
  static bool get isExpired {
    return _token.isNotNullEmpty ? isTokenExpired(_token) : false;
  }
  static int get id {
    try {
      return user.id;
    } catch (e) {
      
    }
    return -1;
  }

  static String get token {
    return _token;
  }

  static set token(String pToken) {
    if (_token.isNotNullEmpty && pToken.isNullEmpty) {
      user = UserModel.fromJson(_decodeToken(_token));
      FirebaseMessagingService.unsubscribeFromTopic("user${user.id}");
    }
    _token = pToken;
    StorageService.set(StorageKeys.token, _token);
    if (_token.isNotNullEmpty) {
      try {
        user = UserModel.fromJson(_decodeToken(_token));
        FirebaseMessagingService.subscribeToTopic("user${user.id}");
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

  static Future<void> init() async {
    try {
      String storetoken = StorageService.get(StorageKeys.token);
      if (storetoken.isNotNullEmpty) {
        token = storetoken;
      }
      if(!isExpired)
      {
        await AuthService.refreshlogin();
      }
    } catch (e) {}
  }

  static bool get isLogin {
    return APITokenService.token != null && APITokenService.token.isNotEmpty;
  }

  // offsetSeconds = 3 days
  static isTokenExpired([String? pToken, int offsetSeconds = 259200]) {
    pToken = pToken ?? APITokenService.token;
    if (pToken == null || pToken.isEmpty) {
      return true;
    }
    try {
      var timeExpiration = _getTokenExpirationDate(pToken);
      offsetSeconds = offsetSeconds ?? 0;
      if (timeExpiration == null) {
        return true;
      }
      //CoreVariables.timeDateServer
      return timeExpiration <
          (DateTime.now().millisecondsSinceEpoch ~/ 1000 + offsetSeconds);
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }

    return true;
  }

  static _getTokenExpirationDate(String pToken) {
    var decoded = _decodeToken(pToken);
    if (decoded["exp"] == null) {
      return null;
    }
    // var date = new DateTime(0); // The 0 here is the key, which sets the date to the epoch
    // date.setUTCSeconds(decoded.exp);
    return decoded["exp"];
  }

  //Dịch mã token
  static _decodeToken(String pToken) {
    var parts = pToken.split('.');
    if (parts?.length != 3) {
      throw 'JWT must have 3 parts';
    }
    var decoded = urlBase64Decode(parts[1]);
    if (decoded.isEmpty) {
      throw 'Cannot decode the token';
    }
    return jsonDecode(decoded);
  }

  static String decodeBase64Utf8(String text) {
    return utf8.fuse(base64).decode(text);
  }

  static String urlBase64Decode(String text) {
    var output = text.replaceAll("-", '+').replaceAll("_", '/');
    switch (output.length % 4) {
      case 0:
        {
          break;
        }
      case 2:
        {
          output += '==';
          break;
        }
      case 3:
        {
          output += '=';
          break;
        }
      default:
        {
          throw 'Illegal base64url string!';
        }
    }
    return decodeBase64Utf8(output);
  }
}
