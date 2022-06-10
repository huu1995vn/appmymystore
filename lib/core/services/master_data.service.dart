import 'dart:convert';

import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';

class MasterDataService {
  static Map<String, dynamic> data = <String, dynamic>{};
  static Future<bool> init() async {
    try {
      int version_masterdata =
          StorageService.get(StorageKeys.version_masterdata);
      dynamic masterdata = StorageService.get(StorageKeys.masterdata);
      if (version_masterdata != null &&
          CommonConfig.version_masterdata <= version_masterdata &&
              masterdata != null) {
        data = json.decode(masterdata);
        return true;
      }
      var res = await DaiLyXeApiBLL_APIRaoXe().getMasterData();
      if (res.status > 0) {
        masterdata = json.decode(res.data)[0]["masterdata"];
        data = json.decode(masterdata);
        StorageService.set(StorageKeys.masterdata, masterdata);
        StorageService.set(StorageKeys.version_masterdata,
            CommonConfig.version_masterdata ?? 1);
      }
      return res.status > 0;
    } catch (e) {
    }
    return false;
  }
}
