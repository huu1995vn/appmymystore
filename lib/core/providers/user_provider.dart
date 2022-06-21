import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
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

  setUserModel({String? fullname, String? img, String? id}) {
    fullname = fullname ?? APITokenService.fullname;
    img = img ?? APITokenService.img.toString();
    id = id ?? APITokenService.userId.toString();
    urlImage =
        CommonMethods.buildUrlHinhDaiDien(int.parse(img), rewriteUrl: fullname);
    notifyListeners();
  }
}
