import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    // selectedPrimaryColor = StorageService.get(StorageKeys.primaryColor) == null
    //     ? AppColors.primary
    //     : Color(StorageService.get(StorageKeys.primaryColor));
    selectedThemeMode = StorageService.get(StorageKeys.themeMode) == null
        ? ThemeMode.light
        : ThemeMode.values.byName(StorageService.get(StorageKeys.themeMode));
    CommonConfig.isDark = selectedThemeMode.name == "dark";
  }
  late ThemeMode selectedThemeMode;

  setSelectedThemeMode(ThemeMode mode) {
    selectedThemeMode = mode;
    StorageService.set(StorageKeys.themeMode, mode.name);
    notifyListeners();
    CommonConfig.isDark = selectedThemeMode.name == "dark";
  }

  enableDarkMode(bool isEnable) {
    var themeMode = isEnable ? ThemeMode.dark : ThemeMode.light;
    setSelectedThemeMode(themeMode);
  }
}
