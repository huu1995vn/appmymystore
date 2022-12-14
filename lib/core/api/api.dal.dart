// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:mymystore/core/services/network/http_template.dart';

class ApiDAL {
  String controllerName = "";
  ApiDAL();
  get(
      {String? actionName,
      Map<String, String>? params,
      Map<String, String>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    
    return HTTPTemplate.get(_controllerName,
        params: params, headers: headers);
  }

  post(dynamic data,
      {String? actionName,
      Map<String, String>? params,
      Map<String, String>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    
    return HTTPTemplate.post(_controllerName, data,
        params: params, headers: headers);
  }

  put(dynamic data,
      {String? actionName,
      Map<String, String>? params,
      Map<String, String>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    
    return HTTPTemplate.put(_controllerName, data,
        params: params, headers: headers);
  }

  delete(dynamic id,
      {String? actionName,
      Map<String, String>? params,
      Map<String, String>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    
    return HTTPTemplate.delete(_controllerName, id,
        params: params, headers: headers);
  }
}
