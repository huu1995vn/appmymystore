// ignore_for_file: empty_catches, unnecessary_null_comparison

import 'dart:convert';
import 'package:mymystore/core/api/api.bll.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:mymystore/core/commons/common_constants.dart';

class MasterDataService {
  static Map<String, dynamic> data = <String, dynamic>{};
  static Future<bool> init() async {
    bool res = false;
    try {
      int versionMasterdata =
          int.parse(StorageService.get(StorageKeys.version) ?? "0");
      dynamic masterdata = StorageService.get(StorageKeys.masterdata);
      if (masterdata is String) {
        masterdata = null;
      }
      if (masterdata != null &&
          versionMasterdata != null &&
          CommonConfig.Version <= versionMasterdata) {
        data = masterdata;
        res = true;
      } else {
        var api = await ApiBLL_APIGets().getMasterData();
        if (api.status > 0) {
          for (var key in api.data.keys) {
            data[key] = jsonDecode(api.data[key]);
          }
          await StorageService.set(StorageKeys.masterdata, data);
          await StorageService.set(
              StorageKeys.version, CommonConfig.Version.toString());
        }
        res = api.status > 0;
      }
      //extends local
      data["price"] = CommonConstants.PRICES;
      data["sort"] = CommonConstants.SORTS;
      data["producttype"] = CommonConstants.PRODUCTTYPES;
      data["productstate"] = CommonConstants.PRODUCTSTATES;
      data["productdoor"] = CommonConstants.PRODUCTDOORS;
      data["productseat"] = CommonConstants.PRODUCTSEATS;
    } catch (e) {}
    return res;
  }

  static String getNameById(String type, int id) {
    try {
      return (data[type] as List)
          .firstWhere((element) => element["id"] == id)["name"];
    } catch (e) {}
    return "";
  }
}
