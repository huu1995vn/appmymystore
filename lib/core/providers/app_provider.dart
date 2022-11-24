import 'package:flutter/material.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/services/api_token.service.dart';

class AppProvider with ChangeNotifier {
  AppProvider();
  UserModel user = UserModel();
  static UserModel localuser = UserModel();

  setUserData({String? pfullname, String? pimage, int? pid}) {
    user.name = pfullname ?? "Nguyễn Văn A";
    user.image = pimage ?? "";
    user.id = pid ?? APITokenService.userId;
    setUserModel(user);
  }

  setAvatarUserModel(String img) {
    user.image = img;
    setUserModel(user);
  }

  setUserModel(UserModel us) {
    user = us;
    AppProvider.localuser = us;
    notifyListeners();
  }
}
