// ignore_for_file: camel_case_types
import 'package:raoxe/core/api/api.dal.dart';
import 'package:raoxe/core/models/response_model.dart';

class ApiBLL_Basic {
  ApiDAL apiDAL = ApiDAL();
  // Use this function in custom-combo.basic1
  Future<ResponseModel> get(
      [Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.get(
        actionName: actionName, queryParameters: queryParameters);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> update(dynamic data,
      [Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.put(data,
        actionName: actionName, queryParameters: queryParameters);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> post(dynamic data,
      [Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.post(data,
        actionName: actionName, queryParameters: queryParameters);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> delete(
      [dynamic id,
      Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.delete(id,
        actionName: actionName, queryParameters: queryParameters);
    return ResponseModel.fromJson(res);
  }
}

class DaiLyXeApiBLL_APIRaoXe extends ApiBLL_Basic {
  DaiLyXeApiBLL_APIRaoXe() {
    apiDAL = ApiDAL();
    apiDAL.controllerName = "ApiRaoXe";
  }
  Future<ResponseModel> login(String username, String password) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = {"username": username, "password": password};
    return post(body, queryParameters, "Login");
  }

  Future<ResponseModel> autologin(String username, String password) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = {};
    return post(body, queryParameters, "AutoLogin");
  }

  Future<ResponseModel> user(String username, String password) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    return get(queryParameters, "Users");
  }
}
