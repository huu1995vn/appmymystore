// ignore_for_file: non_constant_identifier_names

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:universal_platform/universal_platform.dart';

class InfoDevice {
  String? DeviceName;
  String? DeviceVersion;
  String? Identifier;
  String? UniqueDeviceID;
  String? FullDeviceName;
  String? IpAddress;
  dynamic PackageInfo;
  dynamic Position;
  Map<String, dynamic> toJson() => {
        'deviceName': DeviceName,
        'deviceVersion': DeviceVersion,
        'identifier': Identifier,
        'uniqueDeviceID': UniqueDeviceID,
        'fullDeviceName': FullDeviceName,
        'ipAddress': IpAddress,
        'latitude': Position?.latitude,
        'longitude': Position?.longitude,
      };
}

class InfoDeviceService {
  static InfoDevice infoDevice = InfoDevice();
  static Future<InfoDevice> init() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      infoDevice.IpAddress = await CommonMethods.getIPv4();
      infoDevice.PackageInfo = await CommonMethods.getPackageInfo();
      infoDevice.Position = await CommonMethods.getPosition();
      dynamic info;
      if (UniversalPlatform.isAndroid) {
        info = await deviceInfoPlugin.androidInfo;
        infoDevice.DeviceName = info.model;
        infoDevice.DeviceVersion = info.version.toString();
        infoDevice.Identifier = info.androidId; //UUID for Android
        infoDevice.UniqueDeviceID = info.androidId; // uuid android
        infoDevice.FullDeviceName = "${info.brand} - ${info.model}";
      } else {
        if (UniversalPlatform.isIOS) {
          info = await deviceInfoPlugin.iosInfo;
          infoDevice.DeviceName = info.name;
          infoDevice.DeviceVersion = info.systemVersion;
          infoDevice.Identifier = info.identifierForVendor; //UUID for iOS
          infoDevice.UniqueDeviceID = info.identifierForVendor; // uuid ios
          infoDevice.FullDeviceName = "${info.name} - ${info.systemName} - ${info.systemVersion} - ${info.model}";
        } else {
          info = await deviceInfoPlugin.webBrowserInfo;
          infoDevice.DeviceName = info.appName;
          infoDevice.DeviceVersion = info.appVersion;
          infoDevice.Identifier = info.vendor +
              info.userAgent +
              info.hardwareConcurrency.toString();
        }
      }
    } on PlatformException {
      // CommonMethods.wirtePrint('Failed to get platform version');
    }
    return infoDevice;
  }
}
