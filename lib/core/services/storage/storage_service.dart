// ignore_for_file: constant_identifier_names

import 'package:localstorage/localstorage.dart';

class StorageService {
  static String keyStorage = "rx";
  static Map<String, dynamic> dataStorage = <String, dynamic>{};
  static LocalStorage storage = LocalStorage('app');

  static Future<bool> init() async {
    var res = await storage.ready;
    dataStorage = storage.getItem(keyStorage) ?? <String, dynamic>{};
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
  static const String biometrics = 'biometrics';
  static const String userlogin = 'usl';
}
