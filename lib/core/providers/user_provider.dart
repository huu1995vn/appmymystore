import 'package:flutter/material.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';

class UserProvider with ChangeNotifier {
  UserModel user = UserModel();
  static UserModel localuser = UserModel();

  UserProvider() {}
  setData({String? fullname, int? img, int? id}) {
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
    UserProvider.localuser = us;
    notifyListeners();
  }
}
