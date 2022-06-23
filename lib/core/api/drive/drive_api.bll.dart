// ignore_for_file: camel_case_types, depend_on_referenced_packages
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:raoxe/core/entities.dart';
import 'drive_api.dal.dart';
import 'package:path/path.dart' as p;

class DriveApiBLL_Basic {
  DriveApiDAL apiDAL = DriveApiDAL();

  Future<ResponseModel> post(dynamic data,
      {Map<String, dynamic>? queryParameters,
      String? actionName,
      Map<String, dynamic>? headers}) async {
    var res = await apiDAL.post(data,
        actionName: actionName, queryParameters: queryParameters, headers: headers);
    return ResponseModel.fromJson(res);
  }
}

class DriveApiBLL_ApiFile extends DriveApiBLL_Basic {
  DriveApiBLL_ApiFile() {
    apiDAL = DriveApiDAL();
    apiDAL.controllerName = "apifile";
  }
  //uploadfile
  Future<ResponseModel> uploadfile(File file, int fileId, String? name) async {
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    queryParameters["name"] = name ?? p.basename(file.path);
    if (fileId > 0) {
      queryParameters["fileId"] = fileId;
    }

    Map<String, dynamic> headers = <String, dynamic>{};
    var len = await file.length();
    headers = {Headers.contentLengthHeader: len};
    return await post(file.openRead(),
        queryParameters: queryParameters,
        actionName: "appuploadfile",
        headers: headers);
  }

  //User

}
