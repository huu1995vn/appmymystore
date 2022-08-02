// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/entities.dart';
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
          if (doc["DeviceId"]!=null && doc["DeviceId"] != uid) {
            try {
               CommonMethods.showConfirmDialog(
                    context, "message.str047".tr())
                .then((value) => AuthService.logout(context));
            } catch (e) {
              AuthService.logout(context);
            }
           
          }
        }
      });
    }
  }


  static init() async {
    await CloudFirestoreSerivce.configs();
    await CloudFirestoreSerivce.ads();
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

  static Future<void> ads() async {
    try {
      CollectionReference fireStoreService =
          FirebaseFirestore.instance.collection(NAMEFIREBASEDATABASE.ads);
      var value = await fireStoreService.get();
      if (value.docs.isNotEmpty) {
        CommonConfig.ads = value.docs.map((i) {
          dynamic item = i.data();
          return AdsModel.fromJson(item);
        }).toList();
      }
    } catch (e) {}
  }
}
