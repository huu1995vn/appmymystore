import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:mymystore/core/commons/common_constants.dart';

class AppService {
  //#region ViewType
  static ViewType getViewTypeByKey(String key) {
    var viewtype = StorageService.get("${StorageKeys.viewtype}-$key");
    return (viewtype != null && viewtype == ViewType.grid.toString())
        ? ViewType.grid
        : ViewType.list;
  }

  static saveViewTypeByKey(String key, ViewType view) {
    StorageService.set("${StorageKeys.viewtype}-$key", view.toString());
  }
  //#endregion ViewType
}
