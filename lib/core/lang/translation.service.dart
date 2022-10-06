import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'en_US.dart';
import 'vi_VN.dart';

class TranslationService extends Translations {
  static GetStorage _getStorage = GetStorage();
  static String storageKey = 'isVi';

  // locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static final locale = _getLocaleFromLanguage();

// fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static final fallbackLocale = Locale('en', 'US');

// language code của những locale được support
  static final langCodes = [
    'en',
    'vi',
  ];

// các Locale được support
  static final locales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];

// cái này là Map các language được support đi kèm với mã code của lang đó: cái này dùng để đổ data vào Dropdownbutton và set language mà không cần quan tâm tới language của hệ thống
  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });
  static _saveLanguage(bool isVi) {
    _getStorage.write(storageKey, isVi);
  }

  static Locale _getLocale() {
    return isVi() ? locales[1] : locales[0];
  }

// function change language nếu bạn không muốn phụ thuộc vào ngôn ngữ hệ thống
  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale!);
    _saveLanguage(locale!.languageCode == "vi");
  }

  static bool isVi() {
    return _getStorage.read(storageKey) ?? false;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'vi_VN': vi_VN,
      };

  static Locale? _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? (isVi() ? "vi" : "en");
    //  Get.deviceLocale!.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale;
  }
}
