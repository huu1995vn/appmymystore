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
      CommonConfig.api = remoteConfig.getString("api");
    }
    if (configs["apiSufix"] != null) {
      CommonConfig.apiSufix = remoteConfig.getString("apiSufix");
    }
    if (configs["apimymystore"] != null) {
      CommonConfig.apimymystore = remoteConfig.getString("apimymystore");
    }
    if (configs["apimymystoreSufix"] != null) {
      CommonConfig.apimymystoreSufix = remoteConfig.getString("apimymystoreSufix");
    }
    if (configs["apiDrive"] != null) {
      CommonConfig.apiDrive = remoteConfig.getString("apiDrive");
    }
    if (configs["hostDynamicLink"] != null) {
      CommonConfig.hostDynamicLink =
          remoteConfig.getString("hostDynamicLink");
    }
    if (configs["hostmymystore"] != null) {
      CommonConfig.hostmymystore =
          remoteConfig.getString("hostmymystore");
    }
    if (configs["host"] != null) {
      CommonConfig.host =
          remoteConfig.getString("host");
    }
    if (configs["hotSearch"] != null) {
      CommonConfig.hotSearch =
          remoteConfig.getString("hotSearch");
    }
    if (configs["version_masterdata"] != null) {
      CommonConfig.version_masterdata =
          int.parse(remoteConfig.getString("version_masterdata").toString());
    }
    return remoteConfig;
  }
}
