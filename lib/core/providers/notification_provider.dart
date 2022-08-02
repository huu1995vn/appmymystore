import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/entities.dart';

class NotificationProvider with ChangeNotifier {
  int numNotification = 0;
  static UserModel localuser = UserModel();

  NotificationProvider() {}
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

  readeNotification() {
    if (numNotification > 0) {
      numNotification--;
      setNotification(numNotification);
    }
  }

  setNotification(int notification) {
    numNotification = notification;
    notifyListeners();
  }
}
