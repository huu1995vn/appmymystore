// ignore_for_file: void_checks, deprecated_member_use, empty_catches, unused_element, unnecessary_overrides

import 'package:dio/dio.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/firebase/firebase_messaging_service.dart';
import 'package:mymystore/core/services/info_device.service.dart';
import 'dart:convert';

import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:mymystore/core/utilities/extensions.dart';

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
    var token = APITokenService.token;
    if(options.path.toLowerCase().contains("refreshlogin") && APITokenService.token.isNullEmpty)
    {
      token = StorageService.get(StorageKeys.token);
    }
    return "Bearer $token";
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future onError(DioError dioError, ErrorInterceptorHandler handler) async {
    switch (dioError.error) {
      case 404:
        throw "Không tìm thấy";
      default:
    }
    return super.onError(dioError, handler);
  }

  convertValueHeader(value) {
    return Uri.encodeComponent(value.toString());
  }
}
