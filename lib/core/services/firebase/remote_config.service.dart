// ignore_for_file: empty_catches, unnecessary_null_comparison
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mymystore/core/commons/common_configs.dart';

class RemoteConfigSerivce {
  static FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  static Future<FirebaseRemoteConfig> init() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetchAndActivate();
    //FirebaseRemoteConfig sử dụng các giá trị defaule trong file R.xml.default_config nếu không lấy được giá trị
    var configs = remoteConfig.getAll();
    if (configs["api"] != null) {
      CommonConfig.DomainApi = remoteConfig.getString("api");
    }
    if (configs["apiSufix"] != null) {
      CommonConfig.DomainApiSufix = remoteConfig.getString("apiSufix");
    }

    if (configs["apiDynamicLink"] != null) {
      CommonConfig.DomainApiDynamicLink = remoteConfig.getString("apiDynamicLink");
    }
    if (configs["hotSearch"] != null) {
      CommonConfig.HotKeySearch = remoteConfig.getString("hotSearch");
    }
    if (configs["version"] != null) {
      CommonConfig.Version =
          int.parse(remoteConfig.getString("version").toString());
    }
    return remoteConfig;
  }
}
