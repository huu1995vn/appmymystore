import 'package:get_storage/get_storage.dart';
import 'package:raoxe/core/utilities/constants.dart';
class AppService {
  static GetStorage _getStorage = GetStorage();

  //#region ViewType
  static ViewType getViewTypeByKey(String key) {
    var viewtype = _getStorage.read("viewtype-$key");
    return (viewtype!=null && viewtype == ViewType.grid.toString()) ? ViewType.grid: ViewType.list;
  }

  static saveViewTypeByKey(String key, ViewType view) {
    _getStorage.write("viewtype-$key", view.toString());
  }
  //#endregion ViewType
}
