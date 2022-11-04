import 'package:dio/dio.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/services/network/dio_client.dart';

class DioTemplate {
  //function call api drive
  static _buildDriveUrl(String controllerName, [String? addApiHostSufix]) {
    return CommonConfig.apiDrive +
        (addApiHostSufix ?? CommonConfig.apiDriveSufix) +
        controllerName; //crm/
  }

  static postDrive(String controllerName, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildDriveUrl(controllerName);
    return await DioClient.post(requestString, data,
        queryParameters: queryParameters, options: options);
  }


  //function call api 
  static _buildUrl(String controllerName, [String? addApiHostSufix]) {
    return CommonConfig.api +
        (addApiHostSufix ?? CommonConfig.apiSufix) +
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

  //function call api 
  static _buildmymystoreUrl(String controllerName, [String? addApiHostSufix]) {
    return CommonConfig.apimymystore +
        (addApiHostSufix ?? CommonConfig.apimymystoreSufix) +
        controllerName; //crm/
  }

  static getmymystore(String controllerName,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildmymystoreUrl(controllerName);
    return await DioClient.get(requestString,
        queryParameters: queryParameters, options: options);
  }

  static putmymystore(String controllerName, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    var id = -1;
    if (data != null) {
      try {
        id = data["id"] ?? -1;
      } catch (e) {
        id = data.Id ?? -1;
      }
    }
    final requestString = _buildmymystoreUrl(controllerName) +
        (id > 0 ? "/$id" : "");
    return await DioClient.put(requestString, data,
        queryParameters: queryParameters, options: options);
  }

  static postmymystore(String controllerName, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildmymystoreUrl(controllerName);
    return await DioClient.post(requestString, data,
        queryParameters: queryParameters, options: options);
  }


  static deletemymystore(String controllerName, dynamic id,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildmymystoreUrl(controllerName) +
        (id > 0 ? "/$id" : "");
    return await DioClient.delete(requestString,
        queryParameters: queryParameters, options: options);
  }

}
