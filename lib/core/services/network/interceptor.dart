// ignore_for_file: void_checks, deprecated_member_use, empty_catches, unused_element, unnecessary_overrides

import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/firebase/firebase_messaging_service.dart';
import 'package:mymystore/core/services/info_device.service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mymystore/core/utilities/extensions.dart';

class InterceptedClient extends http.BaseClient {
  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    Object? body,
    Encoding? encoding,
  }) async =>
      (await _sendUnstreamed(
        method: "POST",
        url: url,
        headers: headers,
        params: params,
        body: body,
        encoding: encoding,
      ));

  @override
  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    Object? body,
    Encoding? encoding,
  }) async =>
      (await _sendUnstreamed(
        method: "PUT",
        url: url,
        headers: headers,
        params: params,
        body: body,
        encoding: encoding,
      ));
  @override
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    Object? body,
    Encoding? encoding,
  }) async =>
      (await _sendUnstreamed(
        method: "DELETE",
        url: url,
        headers: headers,
        params: params,
        body: body,
        encoding: encoding,
      ));

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _onRequest(request);

    return response;
  }

  Future<http.Response> _sendUnstreamed({
    required String method,
    required Uri url,
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    Object? body,
    Encoding? encoding,
  }) async {
    url = url.addParameters(params);

    http.Request request = http.Request(method, url);

    if (headers != null) request.headers.addAll(headers);
    if (encoding != null) request.encoding = encoding;
    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = body.cast<int>();
      } else if (body is Map) {
        request.body = json.encode(body);
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }
    return http.Response.fromStream(await send(request));
  }

  Future<http.StreamedResponse> _onRequest(http.BaseRequest request) async {
    request = _addHeaders(request);
    String url = request.url.toString().toLowerCase();
    if (url.contains("/updateavatar") || url.contains("/file/upload")) {
      var body = json.decode((request as http.Request).body);
      var requestupload = http.MultipartRequest('POST', request.url);
      requestupload.files
          .add(await http.MultipartFile.fromPath('file', body["file"]));
      requestupload.headers.addAll(request.headers);
      http.StreamedResponse response = await requestupload.send();
      return response;
    } else {
      http.StreamedResponse response = await request.send();
      return response;
    }
  }

  _addHeaders(http.BaseRequest request) {
    var infoDevice = {
      'IPAddress': InfoDeviceService.infoDevice.IpAddress,
      'DeviceId': InfoDeviceService.infoDevice.Identifier,
      'DeviceName': InfoDeviceService.infoDevice.DeviceName,
      'OSName': InfoDeviceService.infoDevice.OSName,
      'Location': InfoDeviceService.infoDevice.location,
      'FCMToken': FirebaseMessagingService.token,
    };
    request.headers.addAll({
      'Authorization': _getToken(request),
      'InfoDevice': CommonMethods.encodeBase64Utf8(jsonEncode(infoDevice)),
      'Content-Type': 'application/json'
    });
    return request;
  }

  String _getToken(http.BaseRequest request) {
    var token = APITokenService.token;
    String path = request.url.toString().toLowerCase();
    if (path.indexOf("/refreshlogin") > 0) {
      return json.decode((request as http.Request).body)["token"];
    }
    return "Bearer $token";
  }

  /// This internal function intercepts the response.
  http.StreamedResponse _onResponse(http.StreamedResponse response) {
    return response;
  }
}
