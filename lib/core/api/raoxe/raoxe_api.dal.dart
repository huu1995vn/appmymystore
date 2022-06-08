// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:raoxe/core/services/network/dio_template.dart';

class RaoXeApiDAL {
  String controllerName = "";
  RaoXeApiDAL();
  get(
      {String? actionName,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    return DioTemplate.getRaoXe(_controllerName, queryParameters: queryParameters);
  }

  post(dynamic data,
      {String? actionName,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    return DioTemplate.postRaoXe(_controllerName, data,
        queryParameters: queryParameters);
  }

  put(dynamic data,
      {String? actionName,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    return DioTemplate.putRaoXe(_controllerName, data,
        queryParameters: queryParameters);
  }

  delete(dynamic id,
      {String? actionName,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    return DioTemplate.deleteRaoXe(_controllerName, id,
        queryParameters: queryParameters);
  }
}
