// ignore_for_file: empty_catches, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/services/info_device.service.dart';
import 'package:raoxe/core/utilities/constants.dart';

class CloudFirestoreSerivce {
  static subcriptuser(BuildContext context) {
    if (APITokenService.userId != null && APITokenService.userId > 0) {
      FirebaseFirestore.instance
          .collection(NAMEFIREBASEDATABASE.users)
          .doc(APITokenService.userId.toString())
          .snapshots()
          .listen((doc) {
        if (doc.exists) {
          String uid = InfoDeviceService.infoDevice.Identifier!;
          if (doc["DeviceId"] != null && doc["DeviceId"] != uid) {
            AuthService.logout(context);
            CommonMethods.showToast("message.str012".tr());
          }
        }
      });
    }
  }

  static init() async {
    await CloudFirestoreSerivce.configs();
  }

  static Future<void> configs() async {
    try {
      CollectionReference fireStoreService =
          FirebaseFirestore.instance.collection(NAMEFIREBASEDATABASE.configs);
      var value = await fireStoreService.get();
      if (value.docs != null && value.docs.isNotEmpty) {
        dynamic item = value.docs[0].data()!;
        CommonConfig.apiDaiLyXe = item["apiDaiLyXe"] ?? CommonConfig.apiDaiLyXe;
        CommonConfig.apiDaiLyXeSufix =
            item["apiDaiLyXeSufix"] ?? CommonConfig.apiDaiLyXeSufix;
        CommonConfig.apiDrive = item["apiDrive"] ?? CommonConfig.apiDrive;
        CommonConfig.version_masterdata =
            item["version_masterdata"] ?? CommonConfig.version_masterdata;
      }
    } catch (e) {}
  }
}
