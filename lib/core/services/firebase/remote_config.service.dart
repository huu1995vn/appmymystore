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
    if (configs["DomainApi"] != null) {
      CommonConfig.DomainApi = remoteConfig.getString("DomainApi");
    }
    if (configs["SufixApi"] != null) {
      CommonConfig.SufixApi = remoteConfig.getString("SufixApi");
    }

    if (configs["DomainDynamicLink"] != null) {
      CommonConfig.DomainDynamicLink = remoteConfig.getString("DomainDynamicLink");
    }
    
    if (configs["Version"] != null) {
      CommonConfig.Version =
          int.parse(remoteConfig.getString("Version").toString());
    }
    return remoteConfig;
  }
}
