// ignore_for_file: non_constant_identifier_names

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:universal_platform/universal_platform.dart';

class InfoDevice {
  String? DeviceName;
  String? DeviceVersion;
  String? Identifier;
  String? IpAddress;
  String? OSName;
  dynamic PackageInfo;
  dynamic Position;
  Map<String, dynamic> toJson() => {
        'deviceName': DeviceName,
        'deviceVersion': DeviceVersion,
        'identifier': Identifier,
        'oSName': OSName,
        'ipAddress': IpAddress,
        'latitude': Position?.latitude,
        'longitude': Position?.longitude,
      };
 String get location
  {
    if(InfoDeviceService.infoDevice.Position?.latitude == null && InfoDeviceService.infoDevice.Position?.longitude ==null ) return "";
    return  "${InfoDeviceService.infoDevice.Position?.latitude??"NaN"},${InfoDeviceService.infoDevice.Position?.longitude??"NaN"}";
  }
}

class InfoDeviceService {
  static InfoDevice infoDevice = InfoDevice();
  static Future<InfoDevice> init() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      CommonMethods.getIPv4().then((value) => {
            infoDevice.IpAddress = value
      });
      infoDevice.PackageInfo = await CommonMethods.getPackageInfo();
      CommonMethods.getPosition().then((value) => {
            infoDevice.Position = value
      });
      dynamic info;

      if (UniversalPlatform.isAndroid) {
        info = await deviceInfoPlugin.androidInfo;
        infoDevice.DeviceName = info.model;
        infoDevice.DeviceVersion = info.version.toString();
        infoDevice.Identifier = info.androidId; //UUID for Android
        infoDevice.OSName = "${info.brand} - ${info.model}";
      } else {
        if (UniversalPlatform.isIOS) {
          info = await deviceInfoPlugin.iosInfo;
          infoDevice.DeviceName = info.name;
          infoDevice.DeviceVersion = info.systemVersion;
          infoDevice.Identifier = info.identifierForVendor; //UUID for iOS
          infoDevice.OSName =
              "${info.name} - ${info.systemName} - ${info.systemVersion} - ${info.model}";
        } else {
          if (UniversalPlatform.isWeb) {
            info = await deviceInfoPlugin.webBrowserInfo;
            infoDevice.DeviceName = info.appName;
            infoDevice.DeviceVersion = info.appVersion;
            infoDevice.Identifier = info.vendor +
                info.userAgent +
                info.hardwareConcurrency.toString();
            infoDevice.OSName = "${info.appName}";
          }
        }
      }
    } on PlatformException {
      // CommonMethods.wirtePrint('Failed to get platform version');
    }
    return infoDevice;
  }
}
