// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:dio/dio.dart';
import 'interceptor.dart';

class DioClient {
  static get(String url,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    return await _request("GET", url,
        queryParameters: queryParameters, options: options);
  }

  static post(String url, body,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    return await _request("POST", url,
        body: body, queryParameters: queryParameters, options: options);
  }

  static put(String url, body,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    return await _request("PUT", url,
        body: body, queryParameters: queryParameters, options: options);
  }

  static delete(String url,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    return await _request("DELETE", url,
        queryParameters: queryParameters, options: options);
  }

  static _request(String strMethod, String path,
      {body, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      body = body ?? {};
      Response res;
      Dio dio = Dio();
      // final performanceInterceptor = DioFirebasePerformanceInterceptor();
      // dio.interceptors.add(performanceInterceptor);
      dio.interceptors.add(DioInterceptors(dio));
  
      switch (strMethod) {
        case "POST":
          res = await dio.post(path,
              data: body, queryParameters: queryParameters, options: options);
          break;
        case "PUT":
          res = await dio.put(path,
              data: body, queryParameters: queryParameters, options: options);
          break;
        case"DELETE":
          res = await dio.delete(path,
              queryParameters: queryParameters, options: options);
          break;
        default:
          res = await dio.get(path,
              queryParameters: queryParameters, options: options);
      }
      var data;
      try {
        data = res.data is Map ? res.data : jsonDecode(res.data);
      } catch (e) {
        data = res.data;
      }
      return data;
    } on DioError catch (e) {
      throw e is String ? e : e.message;
    }
  }
}
