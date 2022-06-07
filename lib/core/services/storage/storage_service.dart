import 'package:localstorage/localstorage.dart';

class StorageService{
  static LocalStorage storage = LocalStorage('app');
  static Future<bool> init()
  {
    return storage.ready;
  }

  /// Retrieves a value from storage
  static dynamic get(String key)
  {
    return storage.getItem(key);
  }

  /// Changes a value in storage
  static Future<void> set(String key, dynamic value){
        return storage.setItem(key, value);

  }
}

class StorageKeys {
  static const String themeMode = 'theme_mode';
  static const String primaryColor = 'primary_color';
  static const String token = 'tk';

}