// ignore_for_file: non_constant_identifier_names, nullable_type_in_catch_clause

import 'package:flutter/services.dart';

class InfoDevice {
  String? DeviceName;
  String? DeviceVersion;
  String? Identifier;
  String? UniqueDeviceID;
  String? FullDeviceName;
  String? IpAddress;
  dynamic Info;
  dynamic PackageInfo;
  Map<String, dynamic> toJson() => {
        'deviceName': DeviceName,
        'deviceVersion': DeviceVersion,
        'identifier': Identifier,
        'uniqueDeviceID': UniqueDeviceID,
        'fullDeviceName': FullDeviceName,
        'ipAddress': IpAddress,
      };
}

class InfoDeviceService {
  static Future<InfoDevice> getInfoDevice() async {
    InfoDevice deviceDetail = InfoDevice();
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      deviceDetail.IpAddress = await CommonMethods.getIPv4();
      deviceDetail.PackageInfo = await CommonMethods.getPackageInfo();

      dynamic info;
      if (UniversalPlatform.isAndroid) {
        info = await deviceInfoPlugin.androidInfo;
        SystemVariables.androidInfo = info;
        deviceDetail.DeviceName = info.model;
        deviceDetail.DeviceVersion = info.version.toString();
        deviceDetail.Identifier = info.androidId; //UUID for Android
        deviceDetail.UniqueDeviceID = info.androidId; // uuid android
        deviceDetail.FullDeviceName =
            sprintf("%s - %s", [info.brand, info.model]);
      } else {
        if (UniversalPlatform.isIOS) {
          info = await deviceInfoPlugin.iosInfo;
          SystemVariables.iosInfo = info;
          deviceDetail.DeviceName = info.name;
          deviceDetail.DeviceVersion = info.systemVersion;
          deviceDetail.Identifier = info.identifierForVendor; //UUID for iOS
          deviceDetail.UniqueDeviceID = info.identifierForVendor; // uuid ios
          deviceDetail.FullDeviceName = sprintf("%s - %s - %s - %s",
              [info.name, info.systemName, info.systemVersion, info.model]);
        } else {
          info = await deviceInfoPlugin.webBrowserInfo;
          SystemVariables.webInfo = info;
          deviceDetail.DeviceName = info.appName;
          deviceDetail.DeviceVersion = info.appVersion;
          deviceDetail.Identifier = info.vendor +
              info.userAgent +
              info.hardwareConcurrency.toString();
        }
      }
      deviceDetail.Info = info;
    } on PlatformException {
      // CommonMethods.wirtePrint('Failed to get platform version');
    }
    return deviceDetail;
  }
}
