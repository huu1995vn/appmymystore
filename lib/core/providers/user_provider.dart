import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';

class UserProvider with ChangeNotifier {
  // late UserModel user = UserModel();
  late String fullname;
  late String img;
  late String id;
  late String urlImage;

  UserProvider() {
    fullname = APITokenService.fullname;
    img = APITokenService.img.toString();
    id = APITokenService.userId.toString();
    urlImage =
        CommonMethods.buildUrlHinhDaiDien(int.parse(img), rewriteUrl: fullname);
  }

  setData({String? fullname, String? img, String? id}) {
    UserModel user = UserModel();
    user.fullname = fullname ?? APITokenService.fullname;
    user.img = img ?? APITokenService.img.toString();
    user.id = id ?? APITokenService.userId.toString();
    setUserModel(user);
  }

  setUserModel(UserModel user) {
    fullname = user.fullname;
    img = user.img;
    id = user.id;
    urlImage = user.URLIMG;
    notifyListeners();
  }
}
