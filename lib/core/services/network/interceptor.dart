// ignore_for_file: void_checks, deprecated_member_use, empty_catches, unused_element, unnecessary_overrides

import 'package:dio/dio.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/firebase/firebase_messaging_service.dart';
import 'package:raoxe/core/services/info_device.service.dart';

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
    options.headers.addAll({
      'Authorization': convertValueHeader(_getToken(options)),
      'IPAddress': convertValueHeader(InfoDeviceService.infoDevice.IpAddress),
      'DeviceId': convertValueHeader(InfoDeviceService.infoDevice.Identifier),
      'DeviceName': convertValueHeader(InfoDeviceService.infoDevice.DeviceName),
      'OSName': convertValueHeader(InfoDeviceService.infoDevice.OSName),
      'Location':
          convertValueHeader("${InfoDeviceService.infoDevice.Position?.latitude},${InfoDeviceService.infoDevice.Position?.longitude}"),
      'FCMToken': convertValueHeader(FirebaseMessagingService.token),

    });
    return options;
  }

  String _getToken(RequestOptions options) {
    String path = options.path.toLowerCase();
    return path.indexOf("apiraoxe/user/") > 0 || path.indexOf("/autologin") > 0 || path.indexOf("/logout") > 0
        ? APITokenService.token
        : APITokenService.getTokenDefaultString;
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
