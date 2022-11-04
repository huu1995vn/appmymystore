// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:mymystore/core/services/network/dio_template.dart';

class ApiDAL {
  String controllerName = "";
  ApiDAL();
  get(
      {String? actionName,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    Options options = Options(headers: headers);

    return DioTemplate.get(_controllerName,
        queryParameters: queryParameters, options: options);
  }

  post(dynamic data,
      {String? actionName,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    Options options = Options(headers: headers);

    return DioTemplate.post(_controllerName, data,
        queryParameters: queryParameters, options: options);
  }

  put(dynamic data,
      {String? actionName,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    Options options = Options(headers: headers);

    return DioTemplate.put(_controllerName, data,
        queryParameters: queryParameters, options: options);
  }

  delete(dynamic id,
      {String? actionName,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    Options options = Options(headers: headers);

    return DioTemplate.delete(_controllerName, id,
        queryParameters: queryParameters, options: options);
  }
}
