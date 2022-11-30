// ignore_for_file: empty_catches, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/auth.service.dart';
import 'package:mymystore/core/services/firebase/firebase_messaging_service.dart';
import 'package:mymystore/core/services/info_device.service.dart';
import 'package:mymystore/core/utilities/constants.dart';

class CloudFirestoreSerivce {
  static subcriptuser(BuildContext context) {
    if (APITokenService.user.id != null && APITokenService.user.id > 0) {
      FirebaseFirestore.instance
          .collection(NAMEFIREBASEDATABASE.users)
          .doc(APITokenService.user.id.toString())
          .snapshots()
          .listen((doc) {
        if (doc.exists) {
          String uid = InfoDeviceService.infoDevice.Identifier!;
          if (doc["DeviceId"] != null && doc["DeviceId"] != uid) {
            AuthService.logout(context);
            if (doc["Status"] != null && doc["Status"] != 1) {
              CommonMethods.showToast("message.str002".tr);
            } else {
              CommonMethods.showToast("message.str012".tr);
            }
          }
        }
      });
    }
  }

  static setdevice({bool isOnline = true}) {
    try {
      var infoDevice = {
        'IPAddress': InfoDeviceService.infoDevice.IpAddress,
        'DeviceId': InfoDeviceService.infoDevice.Identifier,
        'DeviceName': InfoDeviceService.infoDevice.DeviceName,
        'OSName': InfoDeviceService.infoDevice.OSName,
        'Location': InfoDeviceService.infoDevice.location,
        'FCMToken': FirebaseMessagingService.token,
        'UserId': APITokenService.user.id ?? ""
      };
      FirebaseFirestore.instance
          .collection(NAMEFIREBASEDATABASE.devices)
          .doc(InfoDeviceService.infoDevice.Identifier)
          .set(infoDevice);
    } catch (e) {}
  }

  static init() async {
    // await CloudFirestoreSerivce.configs();
  }

  static Future<void> configs() async {
    // try {
    //   CollectionReference fireStoreService =
    //       FirebaseFirestore.instance.collection(NAMEFIREBASEDATABASE.configs);
    //   var value = await fireStoreService.get();
    //   if (value.docs != null && value.docs.isNotEmpty) {
    //     dynamic item = value.docs[0].data()!;
    //     CommonConfig.apiDaiLyXe = item["apiDaiLyXe"] ?? CommonConfig.apiDaiLyXe;
    //     CommonConfig.apiDaiLyXeSufix =
    //         item["apiDaiLyXeSufix"] ?? CommonConfig.apiDaiLyXeSufix;
    //     CommonConfig.apiDrive = item["apiDrive"] ?? CommonConfig.apiDrive;
    //     CommonConfig.version_masterdata =
    //         item["version_masterdata"] ?? CommonConfig.version_masterdata;
    //   }
    // } catch (e) {}
  }
}
