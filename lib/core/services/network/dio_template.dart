import 'package:dio/dio.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/services/network/dio_client.dart';

class DioTemplate {
  static _buildUrl(String controllerName, [String? addApiHostSufix]) {
    return CommonConfig.apiHost +
        (addApiHostSufix ?? CommonConfig.apiHostSufix) +
        controllerName; //crm/
  }

  static get(String controllerName,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildUrl(controllerName);
    return await DioClient.get(requestString,
        queryParameters: queryParameters, options: options);
  }

  static put(String controllerName, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    var id = -1;
    if (data != null) {
      try {
        id = data["id"] ?? -1;
      } catch (e) {
        id = data.Id ?? -1;
      }
    }
    final requestString = _buildUrl(controllerName) +
        (id > 0 ? "/$id" : "");
    return await DioClient.put(requestString, data,
        queryParameters: queryParameters, options: options);
  }

  static post(String controllerName, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildUrl(controllerName);
    return await DioClient.post(requestString, data,
        queryParameters: queryParameters, options: options);
  }


  static delete(String controllerName, dynamic id,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildUrl(controllerName) +
        (id > 0 ? "/$id" : "");
    return await DioClient.delete(requestString,
        queryParameters: queryParameters, options: options);
  }

}
