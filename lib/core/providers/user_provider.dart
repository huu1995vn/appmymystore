import 'package:flutter/material.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';

class UserProvider with ChangeNotifier {
  UserModel user = UserModel();
  UserProvider() {}  
  setData({String? fullname, int? img, int? id}) {
    user.fullname = fullname ?? APITokenService.fullname;
    user.img = img ?? APITokenService.img;
    user.id = id ?? APITokenService.userId;
    setUserModel(user);
  }
  setAvatarUserModel(int img) {
    user.img = img;
    setUserModel(user);
  }
  setUserModel(UserModel us) {
    user = us;
    notifyListeners();
  }
}
