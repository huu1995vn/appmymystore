import 'package:flutter/material.dart';
import 'package:mymystore/core/entities.dart';

class AppProvider with ChangeNotifier {
  AppProvider();
  UserModel user = UserModel();

  setUserModel(UserModel us) {
    user = us;
    notifyListeners();
  }
}
