import 'package:flutter/material.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    // selectedPrimaryColor = StorageService.get(StorageKeys.primaryColor) == null
    //     ? AppColors.primary
    //     : Color(StorageService.get(StorageKeys.primaryColor));
    selectedThemeMode = StorageService.get(StorageKeys.themeMode) == null
        ? ThemeMode.light
        : ThemeMode.values.byName(StorageService.get(StorageKeys.themeMode));
  }
  late ThemeMode selectedThemeMode;

  setSelectedThemeMode(ThemeMode _mode) {
    selectedThemeMode = _mode;
    StorageService.set(StorageKeys.themeMode, _mode.name);
    notifyListeners();
  }

  enableDarkMode(bool isEnable) {
    var themeMode = isEnable ? ThemeMode.dark : ThemeMode.light;
    setSelectedThemeMode(themeMode);
  }
}
