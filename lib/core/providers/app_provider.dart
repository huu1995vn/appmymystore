import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';

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

  int numNotification = 0;

  getNotification() async {
    Map<String, dynamic> params = {
      "p": 1,
      "n": 1,
    };
    ResponseModel res = await DaiLyXeApiBLL_APIUser().notification(params);
    if (res.status > 0) {
      if (res.data != null && res.data.length > 0) {
        List<NotificationModel> list =
            CommonMethods.convertToList<NotificationModel>(
                res.data, (val) => NotificationModel.fromJson(val));
        setNotification(list[0].unread);
      }
    }
  }

  minusNotification() {
    if (numNotification > 0) {
      numNotification--;
      setNotification(numNotification);
    }
  }

  setNotification(int notification) {
    try {
      numNotification = notification;
      notifyListeners();
    } catch (e) {}
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
