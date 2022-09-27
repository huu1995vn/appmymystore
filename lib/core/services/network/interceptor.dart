// ignore_for_file: void_checks, deprecated_member_use, empty_catches, unused_element, unnecessary_overrides

import 'package:dio/dio.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/firebase/firebase_messaging_service.dart';
import 'package:raoxe/core/services/info_device.service.dart';
import 'dart:convert';

class DioInterceptors extends InterceptorsWrapper {
  // ignore: unused_field
  final Dio _dio;
  DioInterceptors(this._dio);
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.path = options.path.toLowerCase();
    options = _addHeaders(options);
    return super.onRequest(options, handler);
  }

  _addHeaders(RequestOptions options) {
    var infoDevice = {
      'IPAddress': InfoDeviceService.infoDevice.IpAddress,
      'DeviceId': InfoDeviceService.infoDevice.Identifier,
      'DeviceName': InfoDeviceService.infoDevice.DeviceName,
      'OSName': InfoDeviceService.infoDevice.OSName,
      'Location': InfoDeviceService.infoDevice.location,
      'FCMToken': FirebaseMessagingService.token,
    };
    options.headers.addAll({
      'Authorization': _getToken(options),
      'InfoDevice': CommonMethods.encodeBase64Utf8(jsonEncode(infoDevice))
    });
    return options;
  }

  String _getToken(RequestOptions options) {
    String path = options.path.toLowerCase();
    return path.indexOf("apiraoxe/user/") > 0 || path.indexOf("/autologin") > 0 || path.indexOf("/logout") > 0
        ? APITokenService.token //token sau khi login chỉ dùng cho các api user
        : APITokenService.getTokenDefaultString; // token default
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future onError(DioError dioError, ErrorInterceptorHandler handler) async {
    return super.onError(dioError, handler);
  }

  convertValueHeader(value)
  {
        return Uri.encodeComponent(value.toString());
  } 
}
