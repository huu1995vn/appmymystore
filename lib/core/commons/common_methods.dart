// ignore_for_file: empty_catches

import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:convert' show base64, jsonDecode, utf8;

import 'package:raoxe/core/services/aes.service.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class CommonMethods {
  static wirtePrint(Object object) {
    if (kDebugMode) {
      if (object is StateError) {
        print(object.message);
      } else {
        print(object.toString());
      }
    }
  }

  static get isLogin {
    return false;
  }

  static Future<PackageInfo?> getPackageInfo() async {
    try {
      return await PackageInfo.fromPlatform();
    } catch (e) {}
    return null;
  }

  static Future<String> getIPv4() async {
    try {
      List<NetworkInterface> lNetworkInterface = await NetworkInterface.list();
      var interface = lNetworkInterface[0];
      return interface.addresses[0].address;
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
    return "";
  }

  static Future<Position?> getPosition() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          Future.error('Location Not Available');
          return null;
        }
      } else {
        return await Geolocator.getCurrentPosition();
      }
    } catch (e) {
      return null;
    }
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString().toUpperCase();
  }

  static String convertBase64FromUrl(String pData) {
    String res = pData.replaceAll('_', '+').replaceAll('-', '/');
    switch (pData.length % 4) {
      case 2:
        res += "==";
        break;
      case 3:
        res += "=";
        break;
    }
    return res;
  }
}
