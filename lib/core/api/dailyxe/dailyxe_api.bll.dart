// ignore_for_file: camel_case_types
import 'package:raoxe/core/api/dailyxe/dailyxe_api.dal.dart';
import 'package:raoxe/core/entities.dart';

class DaiLyXeApiBLL_Basic {
  DaiLyXeApiDAL apiDAL = DaiLyXeApiDAL();
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

class DaiLyXeApiBLL_APIRaoXe extends DaiLyXeApiBLL_Basic {
  DaiLyXeApiBLL_APIRaoXe() {
    apiDAL = DaiLyXeApiDAL();
    apiDAL.controllerName = "ApiRaoXe";
  }
  Future<ResponseModel> login(String username, String password) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = {"username": username, "password": password};
    return post(body, queryParameters, "Login");
  }

  Future<ResponseModel> autologin() async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = {};
    return post(body, queryParameters, "AutoLogin");
  }

  Future<ResponseModel> user() async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    return get(queryParameters, "User");
  }

  Future<ResponseModel> insertuser() async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    return get(queryParameters, "User/insert");
  }

  Future<ResponseModel> updateuser() async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    return get(queryParameters, "User/update");
  }

  Future<ResponseModel> getMasterData() async {
    Map<String, dynamic> body = {};

    return await post(body, null, "masterdata");
  }
}

class DaiLyXeApiBLL_Page extends DaiLyXeApiBLL_Basic {
  DaiLyXeApiBLL_Page() {
    apiDAL = DaiLyXeApiDAL();
    apiDAL.controllerName = "Page";
  }

  Future<ResponseModel> news(Map<String, dynamic> body) async {
    return await post(body, null, "newslist");
  }
}
