import 'package:flutter/material.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class ThemeProvider with ChangeNotifier {

  ThemeProvider() {
    // selectedPrimaryColor = StorageService.get(StorageKeys.primaryColor) == null
    //     ? AppColors.primary
    //     : Color(StorageService.get(StorageKeys.primaryColor));
    selectedThemeMode = StorageService.get(StorageKeys.themeMode) == null
        ? ThemeMode.system
        : ThemeMode.values.byName(StorageService.get(StorageKeys.themeMode));
  }
  //#20220106 tronghuu95 cố định màu primary
  // late Color selectedPrimaryColor;
  // setSelectedPrimaryColor(Color _color) {
  //   selectedPrimaryColor = _color;
  //   StorageService.set(StorageKeys.primaryColor, _color.value);
  //   notifyListeners();
  // }

  late ThemeMode selectedThemeMode;
  setSelectedThemeMode(ThemeMode _mode) {
    selectedThemeMode = _mode;
    StorageService.set(StorageKeys.themeMode, _mode.name);
    notifyListeners();
  }
}
