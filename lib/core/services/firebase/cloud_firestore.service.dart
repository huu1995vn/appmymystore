// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/firebase/firebase_messaging_service.dart';
import 'package:raoxe/core/services/info_device.service.dart';
import 'package:raoxe/core/utilities/constants.dart';

class CloudFirestoreSerivce {
  static Future<void> _pushTokens() async {
    CollectionReference fireStoreService =
        FirebaseFirestore.instance.collection(NAMEFIREBASEDATABASE.tokens);
    try {
      String uid = InfoDeviceService.infoDevice.Identifier!;
      Map<String, dynamic> data = {};
      data["userid"] = APITokenService.userId;
      data["token"] = FirebaseMessagingService.token;
      data["uid"] = uid;
      fireStoreService.doc(uid).set(data);
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
  }

  static init() async {
    _pushTokens();
    await CloudFirestoreSerivce.configs();
    await CloudFirestoreSerivce.banners();
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

  static Future<void> banners() async {
    try {
      CollectionReference fireStoreService =
          FirebaseFirestore.instance.collection(NAMEFIREBASEDATABASE.banners);
      var value = await fireStoreService.get();
      if (value.docs != null && value.docs.isNotEmpty) {
        CommonConfig.banners = value.docs.map((i) {
          dynamic _item = value.docs[0].data();
          BannerModel item = BannerModel();
          item.img = _item["img"];
          item.herf = _item["herf"];
          return item;
        }).toList();
      }
    } catch (e) {}
  }
}
