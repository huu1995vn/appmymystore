// ignore_for_file: constant_identifier_names, empty_catches

import 'package:localstorage/localstorage.dart';
import 'package:mymystore/core/entities.dart';

class StorageService {
  static String keyStorage = "rx";
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

  static deleteItem(String key) {
    dataStorage.remove(key);
    storage.setItem(keyStorage, dataStorage);
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
  static const String token = 'token';
  static const String viewtype = 'viewtype';
}
