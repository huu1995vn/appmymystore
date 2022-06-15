import 'package:dio/dio.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/services/network/dio_client.dart';

class DioTemplate {

  //function call api dailyxe
  static _buildDaiLyXeUrl(String controllerName, [String? addApiHostSufix]) {
    return CommonConfig.apiDaiLyXe +
        (addApiHostSufix ?? CommonConfig.apiDaiLyXeSufix) +
        controllerName; //crm/
  }

  static getDaiLyXe(String controllerName,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildDaiLyXeUrl(controllerName);
    return await DioClient.get(requestString,
        queryParameters: queryParameters, options: options);
  }

  static putDaiLyXe(String controllerName, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    var id = -1;
    if (data != null) {
      try {
        id = data["id"] ?? -1;
      } catch (e) {
        id = data.Id ?? -1;
      }
    }
    final requestString = _buildDaiLyXeUrl(controllerName) +
        (id > 0 ? "/$id" : "");
    return await DioClient.put(requestString, data,
        queryParameters: queryParameters, options: options);
  }

  static postDaiLyXe(String controllerName, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildDaiLyXeUrl(controllerName);
    return await DioClient.post(requestString, data,
        queryParameters: queryParameters, options: options);
  }


  static deleteDaiLyXe(String controllerName, dynamic id,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildDaiLyXeUrl(controllerName) +
        (id > 0 ? "/$id" : "");
    return await DioClient.delete(requestString,
        queryParameters: queryParameters, options: options);
  }

  //function call api dailyxe
  static _buildRaoXeUrl(String controllerName, [String? addApiHostSufix]) {
    return CommonConfig.apiRaoXe +
        (addApiHostSufix ?? CommonConfig.apiRaoXeSufix) +
        controllerName; //crm/
  }

  static getRaoXe(String controllerName,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildRaoXeUrl(controllerName);
    return await DioClient.get(requestString,
        queryParameters: queryParameters, options: options);
  }

  static putRaoXe(String controllerName, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    var id = -1;
    if (data != null) {
      try {
        id = data["id"] ?? -1;
      } catch (e) {
        id = data.Id ?? -1;
      }
    }
    final requestString = _buildRaoXeUrl(controllerName) +
        (id > 0 ? "/$id" : "");
    return await DioClient.put(requestString, data,
        queryParameters: queryParameters, options: options);
  }

  static postRaoXe(String controllerName, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildRaoXeUrl(controllerName);
    return await DioClient.post(requestString, data,
        queryParameters: queryParameters, options: options);
  }


  static deleteRaoXe(String controllerName, dynamic id,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildRaoXeUrl(controllerName) +
        (id > 0 ? "/$id" : "");
    return await DioClient.delete(requestString,
        queryParameters: queryParameters, options: options);
  }

}
