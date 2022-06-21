// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:raoxe/core/services/network/dio_template.dart';

class DriveApiDAL {
  String controllerName = "";
  DriveApiDAL();

  post(dynamic data,
      {String? actionName,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    String _controllerName =
        actionName != null ? "$controllerName/$actionName" : controllerName;
    Options options = Options(headers: headers);

    return DioTemplate.postDrive(_controllerName, data,
        queryParameters: queryParameters, options: options);
  }
}
