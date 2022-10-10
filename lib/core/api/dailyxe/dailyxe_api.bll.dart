// ignore_for_file: camel_case_types
import 'package:raoxe/core/api/dailyxe/dailyxe_api.dal.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/firebase/firebase_messaging_service.dart';

class DaiLyXeApiBLL_Basic {
  DaiLyXeApiDAL apiDAL = DaiLyXeApiDAL();
  // Use this function in custom-combo.basic1
  Future<ResponseModel> get(
      [Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.get(
        actionName: actionName,
        queryParameters: queryParameters,
        headers: headers);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> update(dynamic data,
      [Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.put(data,
        actionName: actionName,
        queryParameters: queryParameters,
        headers: headers);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> post(dynamic data,
      [Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.post(data,
        actionName: actionName,
        queryParameters: queryParameters,
        headers: headers);
    return ResponseModel.fromJson(res);
  }

  Future<ResponseModel> delete(
      [dynamic id,
      Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers]) async {
    var res = await apiDAL.delete(id,
        actionName: actionName,
        queryParameters: queryParameters,
        headers: headers);
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

  Future<ResponseModel> getuserbyid(int id) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = {};
    return await post(body, queryParameters, "user/$id");
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

  Future<ResponseModel> news(Map<String, dynamic> body) async {
    return await post(body, null, "news");
  }

  Future<ResponseModel> newsbyid(dynamic id) async {
    Map<String, dynamic> body = {};
    return await post(body, null, "news/$id");
  }

  Future<ResponseModel> notification(Map<String, dynamic> body) async {
    return await post(body, null, "notification");
  }

  Future<ResponseModel> notificationbyid(dynamic id) async {
    Map<String, dynamic> body = {};
    return await post(body, null, "notification/$id");
  }

  Future<ResponseModel> ranktype(Map<String, dynamic> body) async {
    return await post(body, null, "ranktype");
  }

  Future<ResponseModel> product(Map<String, dynamic> body) async {
    return await post(body, null, "product");
  }

  Future<ResponseModel> productbyid(dynamic id) async {
    Map<String, dynamic> body = {};
    return await post(body, null, "product/$id");
  }

  Future<ResponseModel> favorite(Map<String, dynamic> body) async {
    return await post(body, null, "favorite");
  }

  Future<ResponseModel> review(Map<String, dynamic> body) async {
    return await post(body, null, "review");
  }

  Future<ResponseModel> reviewbyid(dynamic id) async {
    Map<String, dynamic> body = {};
    return await post(body, null, "review/$id");
  }
}

class DaiLyXeApiBLL_APISite extends DaiLyXeApiBLL_Basic {
  DaiLyXeApiBLL_APISite() {
    apiDAL = DaiLyXeApiDAL();
    apiDAL.controllerName = "site/banner";
  }
  //gets
  Future<ResponseModel> getBanner() async {
    return await get(null, "raoxebanner");
  }
}

class DaiLyXeApiBLL_APIUser extends DaiLyXeApiBLL_Basic {
  DaiLyXeApiBLL_APIUser() {
    apiDAL = DaiLyXeApiDAL();
    apiDAL.controllerName = "apiraoxe/user";
  }
  

  Future<ResponseModel> updateuser(Map<String, dynamic> body) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    return await post(body, queryParameters, "update");
  }

  Future<ResponseModel> updateavatar(int bImg) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = <String, dynamic>{};
    body["img"] = bImg;
    return await post(body, queryParameters, "UpdateAvatar");
  }

  Future<ResponseModel> updatephone(String nPhone) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = <String, dynamic>{};
    body["phone"] = nPhone;
    return await post(body, queryParameters, "UpdatePhone");
  }

  Future<ResponseModel> updateemail(String nEmail) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = <String, dynamic>{};
    body["email"] = nEmail;
    return await post(body, queryParameters, "UpdateEmail");
  }

  Future<ResponseModel> product(Map<String, dynamic> body) async {
    return await post(body, null, "product");
  }

  Future<ResponseModel> productbyid(dynamic id) async {
    Map<String, dynamic> body = {};
    return await post(body, null, "product/$id");
  }

  Future<ResponseModel> productsavedata(Map<String, dynamic> body) async {
    return await post(body, null, "product/savedata");
  }

  Future<ResponseModel> productdelete(List<int> ids) async {
    Map<String, dynamic> body = {"ids": ids};
    return await post(body, null, "product/delete");
  }

  Future<ResponseModel> productuptop(Map<String, dynamic> body) async {
    return await post(body, null, "product/uptop");
  }

  Future<ResponseModel> advert(Map<String, dynamic> body) async {
    return await post(body, null, "advert");
  }

  Future<ResponseModel> advertbyid(dynamic id) async {
    Map<String, dynamic> body = {};
    return await post(body, null, "advert/$id");
  }

  Future<ResponseModel> vehiclecontact(Map<String, dynamic> body) async {
    return await post(body, null, "vehiclecontact");
  }

  Future<ResponseModel> vehiclecontactbyid(dynamic id) async {
    Map<String, dynamic> body = {};
    return await post(body, null, "vehiclecontact/$id");
  }

  Future<ResponseModel> vehiclecontactready(List<int> ids) async {
    Map<String, dynamic> body = {"ids": ids, "status": 2};
    return await post(body, null, "vehiclecontact/status");
  }

  Future<ResponseModel> vehiclecontactdelete(List<int> ids) async {
    Map<String, dynamic> body = {"ids": ids};
    return await post(body, null, "vehiclecontact/delete");
  }

  Future<ResponseModel> contact(Map<String, dynamic> body) async {
    return await post(body, null, "contact");
  }

  Future<ResponseModel> notification(Map<String, dynamic> body) async {
    return await post(body, null, "notification");
  }

  Future<ResponseModel> notificationbyid(dynamic id) async {
    Map<String, dynamic> body = {};
    return await post(body, null, "notification/$id");
  }

  Future<ResponseModel> notificationready(List<int> ids) async {
    Map<String, dynamic> body = {"ids": ids, "status": 2};
    return await post(body, null, "notification/status");
  }

  Future<ResponseModel> notificationdelete(List<int> ids) async {
    Map<String, dynamic> body = {"ids": ids};
    return await post(body, null, "notification/delete");
  }

  Future<ResponseModel> contactbyid(dynamic id) async {
    Map<String, dynamic> body = {};
    return await post(body, null, "contact/$id");
  }

  Future<ResponseModel> contactsavedata(Map<String, dynamic> body) async {
    return await post(body, null, "contact/savedata");
  }

  Future<ResponseModel> contactdelete(Map<String, dynamic> body) async {
    return await post(body, null, "contact/delete");
  }

  Future<ResponseModel> contactdefault(Map<String, dynamic> body) async {
    return await post(body, null, "contact/default");
  }

  Future<ResponseModel> favorite(Map<String, dynamic> body) async {
    return await post(body, null, "favorite");
  }

  Future<ResponseModel> favoritepost(List<int> ids, bool status) async {
    Map<String, dynamic> body = {"ids": ids, "status": status};
    return await post(body, null, "favorite/post");
  }

  Future<ResponseModel> favoritedelete(Map<String, dynamic> body) async {
    return await post(body, null, "favorite/delete");
  }

  Future<ResponseModel> review(Map<String, dynamic> body) async {
    return await post(body, null, "review");
  }

  Future<ResponseModel> reviewbyid(dynamic id) async {
    Map<String, dynamic> body = {};
    return await post(body, null, "review/$id");
  }

  Future<ResponseModel> reviewpost(Map<String, dynamic> body) async {
    return await post(body, null, "review/post");
  }

  Future<ResponseModel> reviewdelete(Map<String, dynamic> body) async {
    return await post(body, null, "review/delete");
  }

  Future<ResponseModel> reportpost(Map<String, dynamic> body) async {
    return await post(body, null, "report/post");
  }

  Future<ResponseModel> topics() async {
    Map<String, dynamic> body = {"token": FirebaseMessagingService.token};
    return await post(body, null, "topics");
  }
}

class DaiLyXeApiBLL_APIAnonymous extends DaiLyXeApiBLL_Basic {
  DaiLyXeApiBLL_APIAnonymous() {
    apiDAL = DaiLyXeApiDAL();
    apiDAL.controllerName = "apiraoxe/anonymous";
  }

  //anonymous
  Future<ResponseModel> insertuser(Map<String, dynamic> body) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    return await post(body, queryParameters, "insertuser");
  }

  Future<ResponseModel> forgotpassword(
      String nUserName, String nPassword) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = <String, dynamic>{
      "username": nUserName,
      "password": nPassword
    };
    return await post(body, queryParameters, "forgotpassword");
  }

  Future<ResponseModel> sendotpemail(String email) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = <String, dynamic>{"email": email};
    return await post(body, queryParameters, "sendotpemail");
  }

  Future<ResponseModel> verifyotpemail(String email, String code) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> body = <String, dynamic>{"email": email, "code": code};
    return await post(body, queryParameters, "verifyotpemail");
  }
}
