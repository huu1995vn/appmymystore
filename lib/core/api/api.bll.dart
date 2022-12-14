// ignore_for_file: camel_case_types
import 'package:mymystore/core/api/api.dal.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/services/firebase/firebase_messaging_service.dart';

class ApiBLL_Basic {
  ApiDAL apiDAL = ApiDAL();
  // Use this function in custom-combo.basic1
  Future<ResponseModel> get(
      [Map<String, String>? params,
      String? actionName,
      Map<String, String>? headers]) async {
    var res = await apiDAL.get(
        actionName: actionName, params: params, headers: headers);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> update(dynamic data,
      [Map<String, String>? params,
      String? actionName,
      Map<String, String>? headers]) async {
    var res = await apiDAL.put(data,
        actionName: actionName, params: params, headers: headers);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> post(dynamic data,
      [Map<String, String>? params,
      String? actionName,
      Map<String, String>? headers]) async {
    var res = await apiDAL.post(data,
        actionName: actionName, params: params, headers: headers);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> delete(
      [dynamic id,
      Map<String, String>? params,
      String? actionName,
      Map<String, String>? headers]) async {
    var res = await apiDAL.delete(id,
        actionName: actionName, params: params, headers: headers);
    return ResponseModel.fromJson(res);
  }
}

class ApiBLL_APIToken extends ApiBLL_Basic {
  ApiBLL_APIToken() {
    apiDAL = ApiDAL();
    apiDAL.controllerName = "api/token";
  }
  //login
  Future<ResponseModel> login(String pusername, String ppassword) async {
    Map<String, String> params = <String, String>{};
    Map<String, String> body = {"username": pusername, "password": ppassword};
    return await post(body, params, "Login");
  }

  Future<ResponseModel> refreshlogin(String ptoken) async {
    Map<String, String> params = <String, String>{};
    Map<String, String> body = {
      "token": ptoken
    };
    return await post(body, params, "refreshlogin");
  }
  //User
}

class ApiBLL_APIGets extends ApiBLL_Basic {
  ApiBLL_APIGets() {
    apiDAL = ApiDAL();
    apiDAL.controllerName = "api/gets";
  }
  //gets
  Future<ResponseModel> getMasterData() async {
    Map<String, String> body = {};
    return await post(body, null, "masterdata");
  }

  Future<ResponseModel> getuserbyid(int id) async {
    Map<String, String> params = <String, String>{};
    Map<String, String> body = {};
    return await post(body, params, "user/$id");
  }

  Future<ResponseModel> statsuser(Map<String, String> body) async {
    return await post(body, null, "statususer");
  }

  Future<ResponseModel> suggest(String textsearch) async {
    Map<String, String> body = {"s": textsearch};
    return await post(body, null, "suggest");
  }

  Future<ResponseModel> mymystore(Map<String, String> body) async {
    return await post(body, null, "mymystore");
  }

  Future<ResponseModel> news(Map<String, String> body) async {
    return await post(body, null, "news");
  }

  Future<ResponseModel> newsbyid(dynamic id) async {
    Map<String, String> body = {};
    return await post(body, null, "news/$id");
  }

  Future<ResponseModel> notification(Map<String, String> body) async {
    return await post(body, null, "notification");
  }

  Future<ResponseModel> notificationbyid(dynamic id) async {
    Map<String, String> body = {};
    return await post(body, null, "notification/$id");
  }

  Future<ResponseModel> ranktype(Map<String, String> body) async {
    return await post(body, null, "ranktype");
  }

  Future<ResponseModel> product(Map<String, String> body) async {
    return await post(body, null, "product");
  }

  Future<ResponseModel> productbyid(dynamic id) async {
    Map<String, String> body = {};
    return await post(body, null, "product/$id");
  }

  Future<ResponseModel> favorite(Map<String, String> body) async {
    return await post(body, null, "favorite");
  }

  Future<ResponseModel> review(Map<String, String> body) async {
    return await post(body, null, "review");
  }

  Future<ResponseModel> reviewbyid(dynamic id) async {
    Map<String, String> body = {};
    return await post(body, null, "review/$id");
  }
}

class ApiBLL_APISite extends ApiBLL_Basic {
  ApiBLL_APISite() {
    apiDAL = ApiDAL();
    apiDAL.controllerName = "site/banner";
  }
  //gets
  Future<ResponseModel> getBanner() async {
    return await get(null, "mymystorebanner");
  }
}

class ApiBLL_APIUser extends ApiBLL_Basic {
  ApiBLL_APIUser() {
    apiDAL = ApiDAL();
    apiDAL.controllerName = "api/user";
  }

  Future<ResponseModel> updateuser(Map<String, String> body) async {
    Map<String, String> params = <String, String>{};
    return await post(body, params, "update");
  }

  Future<ResponseModel> updateavatar(String purl) async {
    Map<String, String> params = <String, String>{};
    Map<String, String> body = <String, String>{};
    body["image"] = purl;
    return await post(body, params, "UpdateAvatar");
  }

  Future<ResponseModel> updatephone(String nPhone) async {
    Map<String, String> params = <String, String>{};
    Map<String, String> body = <String, String>{};
    body["phone"] = nPhone;
    return await post(body, params, "UpdatePhone");
  }
}
