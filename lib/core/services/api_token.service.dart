import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/services/aes.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class APITokenService {
  static String _token = "";
  static dynamic adminId;
  static bool isExpired = false;
  static bool isValid = true;
  static String get _getTokenDefaultString {
    String token = "";
    try {
      int expired = DateTime.now().add(const Duration(days: 1)).ticks;
      String value = "-1|${expired.toString()}";
      String code = CommonMethods.generateMd5("${value}${TOKEN_SECURITY_KEY}");
      String resAes = AESService.encrypt("$value.$code");
      token = resAes.replaceAll('+', '_').replaceAll('/', '-').split("=")[0];
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
    return token;
  }
  static String get token {
    if (_token.isNullEmpty) {
      _token = StorageService.get(StorageKeys.token);
    }
    if (_token.isNotNullEmpty) {
      return _token;
    } else {
      return _getTokenDefaultString;
    }
  }
  static set token (String pToken) {
    _token = pToken;
    StorageService.set(StorageKeys.token, pToken);
     isValid = false;
    try {
      dynamic tokenSplit =
          AESService.decrypt(CommonMethods.convertBase64FromUrl(pToken)).split('.');
      if (CommonMethods.generateMd5(tokenSplit[0] + TOKEN_SECURITY_KEY) ==
          tokenSplit[1]) {
        dynamic values = tokenSplit[0].split('|');
        adminId = int.parse(values[0]);
        isExpired = DateTime.now().ticks > int.parse(values[1]);
        isValid = true;
      }
    } catch (ex) {
      // throw new Exception(CommonConstants.MESSAGE_TOKEN_INVALID + string.Format(" ({0})", ex.Message));
    }
  }
}
