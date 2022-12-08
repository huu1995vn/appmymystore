import 'package:dio/dio.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/services/network/dio_client.dart';

class DioTemplate {
  //function call api dailyxe
  static _buildUrl(String pCtrlName, [String? pSufixApi]) {
    return CommonConfig.DomainApi +
        (pSufixApi ?? CommonConfig.SufixApi) +
        pCtrlName; //crm/
  }

  static get(String pCtrlName,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildUrl(pCtrlName);
    return await DioClient.get(requestString,
        queryParameters: queryParameters, options: options);
  }

  static put(String pCtrlName, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    var id = -1;
    if (data != null) {
      try {
        id = data["id"] ?? -1;
      } catch (e) {
        id = data.Id ?? -1;
      }
    }
    final requestString = _buildUrl(pCtrlName) + (id > 0 ? "/$id" : "");
    return await DioClient.put(requestString, data,
        queryParameters: queryParameters, options: options);
  }

  static post(String pCtrlName, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildUrl(pCtrlName);
    return await DioClient.post(requestString, data,
        queryParameters: queryParameters, options: options);
  }

  static delete(String pCtrlName, dynamic id,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final requestString = _buildUrl(pCtrlName) + (id > 0 ? "/$id" : "");
    return await DioClient.delete(requestString,
        queryParameters: queryParameters, options: options);
  }
}
