import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/services/network/http_client.dart';

class HTTPTemplate {
  //function call api dailyxe
  static _buildUrl(String pCtrlName, [String? pSufixApi]) {
    return CommonConfig.DomainApi +
        (pSufixApi ?? CommonConfig.SufixApi) +
        pCtrlName; //crm/
  }

  static get(String pCtrlName,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    final requestString = _buildUrl(pCtrlName);
    return await HTTPClient.get(requestString,
        params: params, headers: headers);
  }

  static put(String pCtrlName, dynamic data,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    var id = -1;
    if (data != null) {
      try {
        id = data["id"] ?? -1;
      } catch (e) {
        id = data.Id ?? -1;
      }
    }
    final requestString = _buildUrl(pCtrlName) + (id > 0 ? "/$id" : "");
    return await HTTPClient.put(requestString, data,
        params: params, headers: headers);
  }

  static post(String pCtrlName, dynamic data,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    final requestString = _buildUrl(pCtrlName);
    return await HTTPClient.post(requestString, data,
        params: params, headers: headers);
  }

  static delete(String pCtrlName, dynamic id,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    final requestString = _buildUrl(pCtrlName) + (id > 0 ? "/$id" : "");
    return await HTTPClient.delete(requestString,
        params: params, headers: headers);
  }
}
