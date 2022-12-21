import 'package:flutter/material.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/services/api_token.service.dart';

class AppProvider with ChangeNotifier {
  AppProvider();
  UserModel user = UserModel();
  static UserModel localuser = UserModel();

  setUserData({String? pfullname, int? pfileid, int? pid}) {
    user.name = pfullname ?? "Nguyễn Văn A";
    user.fileid = pfileid ?? -1;
    user.id = pid ?? APITokenService.id;
    setUserModel(user);
  }

  setAvatarUserModel(int pfileid) {
    user.fileid = pfileid;
    setUserModel(user);
  }

  setUserModel(UserModel us) {
    user = us;
    AppProvider.localuser = us;
    notifyListeners();
  }
}
