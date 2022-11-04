import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';

class ThemeService {
  final storageKey = 'isDarkMode';

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSavedDarkMode() {
    return StorageService.get(storageKey) ?? false;
  }

  void saveThemeMode(bool isDarkMode) {
    StorageService.set(storageKey, isDarkMode);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isSavedDarkMode());
  }
}
