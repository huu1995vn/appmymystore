// ignore_for_file: camel_case_types
import 'package:raoxe/core/api/dailyxe/dailyxe_api.dal.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';

class DaiLyXeApiBLL_Basic {
  DaiLyXeApiDAL apiDAL = DaiLyXeApiDAL();
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

class DaiLyXeApiBLL_APIAuth extends DaiLyXeApiBLL_Basic {
  DaiLyXeApiBLL_APIAuth() {
    apiDAL = DaiLyXeApiDAL();
    apiDAL.controllerName = "apiraoxe/auth";
  }
  //login
  Future<ResponseModel> login(String username, String password) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = {"username": username, "password": password};
    return await post(body, queryParameters, "Login");
  }

  Future<ResponseModel> autologin() async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = {};
    return await post(body, queryParameters, "AutoLogin");
  }
  //User

}

class DaiLyXeApiBLL_APIGets extends DaiLyXeApiBLL_Basic {
  DaiLyXeApiBLL_APIGets() {
    apiDAL = DaiLyXeApiDAL();
    apiDAL.controllerName = "apiraoxe/gets";
  }
  //gets
  Future<ResponseModel> getMasterData() async {
    Map<String, dynamic> body = {};
    return await post(body, null, "masterdata");
  }

  Future<ResponseModel> statsuser(Map<String, dynamic> body) async {
    return await post(body, null, "statususer");
  }

  Future<ResponseModel> suggest(String textsearch) async {
    Map<String, dynamic> body = {"s": textsearch};
    return await post(body, null, "suggest");
  }

  Future<ResponseModel> raoxe(Map<String, dynamic> body) async {
    return await post(body, null, "raoxe");
  }

  Future<ResponseModel> newslist(Map<String, dynamic> body) async {
    return await post(body, null, "newslist");
  }

  Future<ResponseModel> newsdetail(dynamic id) async {
    Map<String, dynamic> body = {"id": id};
    return await post(body, null, "newsdetail");
  }

   Future<ResponseModel> ratinglist(Map<String, dynamic> body) async {
    return await post(body, null, "ratinglist");
  }

  
}

class DaiLyXeApiBLL_APIUser extends DaiLyXeApiBLL_Basic {
  DaiLyXeApiBLL_APIUser() {
    apiDAL = DaiLyXeApiDAL();
    apiDAL.controllerName = "apiraoxe/user";
  }

  Future<ResponseModel> getuser() async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = {};
    return await post(body, queryParameters, "${APITokenService.userId}");
  }

  Future<ResponseModel> updateuser(Map<String, dynamic> body) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    return await post(body, queryParameters, "update");
  }
  
  Future<ResponseModel> advertlist(Map<String, dynamic> body) async {
    return await post(body, null, "advertlist");
  }

  Future<ResponseModel> advertdetail(dynamic id) async {
    Map<String, dynamic> body = {"id": id};
    return await post(body, null, "advertdetail");
  }
}

class DaiLyXeApiBLL_APIAnonymous extends DaiLyXeApiBLL_Basic {
  DaiLyXeApiBLL_APIAnonymous() {
    apiDAL = DaiLyXeApiDAL();
    apiDAL.controllerName = "apiraoxe/anonymous";
  }

  //anonymous
  Future<ResponseModel> insertuser() async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = {};
    return await post(body, queryParameters, "insertuser");
  }
}
