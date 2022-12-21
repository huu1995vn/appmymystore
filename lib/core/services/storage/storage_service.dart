// ignore_for_file: constant_identifier_names, empty_catches

import 'package:localstorage/localstorage.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/services/api_token.service.dart';

class StorageService {
  static String keyStorage = "mm";
  static Map<String, dynamic> dataStorage = <String, dynamic>{};
  static LocalStorage storage = LocalStorage('app');
  static List<int> listFavorite = [];
  static Future<bool> init() async {
    var res = await storage.ready;
    try {
      dataStorage = storage.getItem(keyStorage) ?? <String, dynamic>{};
    } catch (e) {}
    return res;
  }

  /// Retrieves a value from storage
  static dynamic get(String key) {
    return dataStorage[key];
  }

  /// Changes a value in storage
  static Future<void> set(String key, dynamic value) async {
    dataStorage[key] = value;
    await storage.setItem(keyStorage, dataStorage);
  }

  static Future<void> deleteItem(String key) async {
    dataStorage.remove(key);
    await storage.setItem(keyStorage, dataStorage);
  }

  static String getUserLogin() {
    try {
      return StorageService.get(StorageKeys.userlogin);
    } catch (e) {}
    return "";
  }

  static setUserLogin(String username) async {
    await StorageService.set(StorageKeys.userlogin, username);
  }

  static deleteBiometric() async {
    await StorageService.deleteItem(StorageKeys.biometric);
  }

  static setBiometric() async {
    await StorageService.set(StorageKeys.biometric,
        "###${APITokenService.id}###${APITokenService.token}");
  }

  static updateBiometric() async {
    String? biometric = getBiometric();
    if (biometric != null &&
        biometric.contains("###${APITokenService.id}###")) {
      await StorageService.set(StorageKeys.biometric,
          "###${APITokenService.id}###${APITokenService.token}");
    } else {
      if (biometric != null) {
        await deleteBiometric();
      }
    }
  }

  static String? getBiometric() {
    return StorageService.get(StorageKeys.biometric);
  }

  static bool enableBiometric() {
    String? biometric = getBiometric();
    if (biometric == null) return false;
    return biometric.contains("###${APITokenService.id}###");
  }

  static String getTokenBiometric() {
    String? biometric = getBiometric();
    if (biometric == null) return "";
    return biometric.replaceAll(RegExp(r'###(\d+)###'), "");
  }
}

class StorageKeys {
  static const String themeMode = 'theme_mode';
  static const String primaryColor = 'primary_color';
  static const String dataLogin = 'dl';
  static const String masterdata = 'msd';
  static const String version_masterdata = 'vmsd';
  static const String text_search = 'text_search';
  static const String biometric = 'biometric';
  static const String userlogin = 'usl';
  static const String favorite = 'fv';
  static const String token = 'token';
  static const String viewtype = 'viewtype';
}
