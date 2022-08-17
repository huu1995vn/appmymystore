// ignore_for_file: non_constant_identifier_names

import 'package:raoxe/core/services/info_device.service.dart';
import 'package:raoxe/enviroments/prod.dart';
import 'package:raoxe/enviroments/dev.dart';

enum Environment {
  dev,
  prod,
}

class CommonConfig {
  //system
  static bool isDark = false;
  static Map deviceInfo = {};
  static String languageCode = "vi";
  static String env = "dev";
  static String apiDaiLyXe = "http://api.dailyxe.info";
  static String apiDaiLyXeSufix = "/";
  static String apiRaoXe = "https://raoxe.dailyxe.info";
  static String apiRaoXeSufix = "/";
  static String apiDrive = "http://cdn.dailyxe.info";
  static String apiDriveSufix = "/";
  static String apiHost = "https://dailyxe.com.vn";
  static String hostDynamicLinks = "https://raoxe.page.link";
  static String appStoreID = "1486119532";
  static bool haveCacheImage = true;
  static int version_masterdata = 1;
  static int timeVerify = 2; // phút
  static String hotSearch = "vinfast,ford,xe moi";
  static late Map<String, dynamic> _config;
  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = configDev;
        break;
      case Environment.prod:
        _config = configProd;
        break;
    }
    CommonConfig.env = _config["env"];
    CommonConfig.apiDaiLyXe = _config["apiDaiLyXe"] ?? CommonConfig.apiDaiLyXe;
    CommonConfig.apiDaiLyXeSufix =
        _config["apiDaiLyXeSufix"] ?? CommonConfig.apiDaiLyXeSufix;
    CommonConfig.apiRaoXe = _config["apiRaoXe"] ?? CommonConfig.apiRaoXe;
    CommonConfig.apiRaoXeSufix =
        _config["apiHostSufixRaoXe"] ?? CommonConfig.apiRaoXeSufix;
    CommonConfig.apiDrive = _config["apiDrive"] ?? CommonConfig.apiDrive;
    CommonConfig.hostDynamicLinks =
        _config["hostDynamicLinks"] ?? CommonConfig.hostDynamicLinks;
  }

  static Map<String, String> linkContent = {
    "dieuKhoan":
        "https://docs.google.com/document/d/e/2PACX-1vSCwdwfhncFilHGBq30Wf4RFoj4eDmFNuFs8yNOsPTl-SANYiITlxYBr7SNLKi7Iw/pub?embedded=true",
    "chinhSach":
        "https://docs.google.com/document/d/e/2PACX-1vS9_o2O2dMj8ZKzm21RiYBbs9_Z94Zl2l6vKUw6uGMCwyg4_AixftAO-lp0rj4fMneuWbJoxcjB9j64/pub?embedded=true",
    "feedBack":
        "https://docs.google.com/forms/d/e/1FAIpQLSdXiEoL4SAs25rhsn-TM_Qa6-aiqTi5EyKxb6wgad4PIaDSJg/viewform?embedded=true&entry.1829567736=%s&entry.1507208422=%s",
    "gopYBaoLoi":
        "https://docs.google.com/forms/d/e/1FAIpQLSc_jGYUcXvRieynLykLPjjf-r41L2CT5OAiqUn93OvcmwQzAg/viewform?usp=sf_link&entry.407002442=%s&entry.67388375=%s",
    "linkAppAndroid":
        "http://play.google.com/store/apps/details?id=${InfoDeviceService.infoDevice.PackageInfo.packageName}",
    "linkAppIos": "https://itunes.apple.com/app/id${CommonConfig.appStoreID}",
  };
}
