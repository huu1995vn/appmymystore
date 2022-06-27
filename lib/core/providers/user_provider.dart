import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';

class UserProvider with ChangeNotifier {
  String? fullname;
  int img = 0;
  int id = 0;
  String? urlImage;

  UserProvider() {
    fullname = APITokenService.fullname;
    img = APITokenService.img;
    id = APITokenService.userId;
    urlImage =
        CommonMethods.buildUrlHinhDaiDien(img, rewriteUrl: fullname);
  }

  setData({String? fullname, int? img, int? id}) {
    UserModel user = UserModel();
    user.fullname = fullname ?? APITokenService.fullname;
    user.img = img ?? APITokenService.img;
    user.id = id ?? APITokenService.userId;
    setUserModel(user);
  }

  setUserModel(UserModel user) {
    fullname = user.fullname!;
    img = user.img;
    id = user.id;
    urlImage = user.rximg;
    notifyListeners();
  }
}
