import 'package:flutter/material.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/services/api_token.service.dart';

class AppProvider with ChangeNotifier {
  AppProvider();
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
