// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mymystore/core/services/network/interceptor.dart';

class HTTPClient {
  static get(String url,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    return await _request("GET", url,
        params: params, headers: headers);
  }

  static post(String url, body,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    return await _request("POST", url,
        body: body, params: params, headers: headers);
  }

  static put(String url, body,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    return await _request("PUT", url,
        body: body, params: params, headers: headers);
  }

  static delete(String url,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    return await _request("DELETE", url,
        params: params, headers: headers);
  }

  static _request(String strMethod, String path,
      {body, Map<String, dynamic>? params, Map<String, String>? headers}) async {
    try {

      var client = InterceptedClient();
      http.Response res;
   
      switch (strMethod) {
        case "POST":
          res = await client.post(Uri.parse(path),
              body: body, params: params, headers: headers);
          break;
        case "PUT":
          res = await client.put(Uri.parse(path),
              body: body, params: params, headers: headers);
          break;
        case "DELETE":
          res = await client.delete(Uri.parse(path),
              params: params, headers: headers);
          break;
        default:
          res = await client.get(Uri.parse(path), headers: headers);
      }
      var data;
      try {
        data = res.body is Map ? res.body : jsonDecode(res.body);
      } catch (e) {
        data = res.body;
      }
      return data;
    } on dynamic catch (e) {
      throw e is String ? e : e.message;
    }
  }
}
