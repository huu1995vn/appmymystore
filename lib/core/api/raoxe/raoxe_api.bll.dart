// ignore_for_file: camel_case_types
import 'package:raoxe/core/api/raoxe/raoxe_api.dal.dart';
import 'package:raoxe/core/entities.dart';

class RaoXeApiBLL_Basic {
  RaoXeApiDAL apiDAL = RaoXeApiDAL();
  // Use this function in custom-combo.basic1
  Future<ResponseModel> get(
      [Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.get(
        actionName: actionName, queryParameters: queryParameters, headers: headers);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> update(dynamic data,
      [Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.put(data,
        actionName: actionName, queryParameters: queryParameters, headers: headers);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> post(dynamic data,
      [Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.post(data,
        actionName: actionName, queryParameters: queryParameters, headers: headers);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> delete(
      [dynamic id,
      Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.delete(id,
        actionName: actionName, queryParameters: queryParameters, headers: headers);
    return ResponseModel.fromJson(res);
  }
}

// class RaoXeRaoXeApiBLL_APIRaoXe extends RaoXeApiBLL_Basic {
//   RaoXeRaoXeApiBLL_APIRaoXe() {
//     apiDAL = RaoXeApiDAL();
//     apiDAL.controllerName = "ApiRaoXe";
//   }
//   Future<ResponseModel> login(String username, String password) async {
//     Map<String, dynamic> queryParameters = <String, dynamic>{};
//     Map<String, dynamic> body = {"username": username, "password": password};
//     return post(body, queryParameters, "Login");
//   }

//   Future<ResponseModel> autologin(String username, String password) async {
//     Map<String, dynamic> queryParameters = <String, dynamic>{};
//     Map<String, dynamic> body = {};
//     return post(body, queryParameters, "AutoLogin");
//   }

//   Future<ResponseModel> user(String username, String password) async {
//     Map<String, dynamic> queryParameters = <String, dynamic>{};
//     return get(queryParameters, "Users");
//   }
// }
