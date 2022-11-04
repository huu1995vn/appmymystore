import 'package:flutter/material.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';

class AppProvider with ChangeNotifier {
  AppProvider() {
    // selectedPrimaryColor = StorageService.get(StorageKeys.primaryColor) == null
    //     ? AppColors.primary
    //     : Color(StorageService.get(StorageKeys.primaryColor));
    // selectedThemeMode = StorageService.get(StorageKeys.themeMode) == null
    //     ? ThemeMode.light
    //     : ThemeMode.values.byName(StorageService.get(StorageKeys.themeMode));
    // Get.isDarkMode = selectedThemeMode.name == "dark";
  }


  UserModel user = UserModel();
  static UserModel localuser = UserModel();

  setUserData({String? fullname, int? img, int? id}) {
    user.fullname = fullname ?? "Nguyễn Văn A";
    user.img = img ?? -1;
    user.id = id ?? APITokenService.userId;
    setUserModel(user);
  }

  setAvatarUserModel(int img) {
    user.img = img;
    setUserModel(user);
  }

  setUserModel(UserModel us) {
    user = us;
    AppProvider.localuser = us;
    notifyListeners();
  }
}
