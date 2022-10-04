// ignore_for_file: empty_catches, unnecessary_null_comparison
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:raoxe/core/commons/common_configs.dart';

class RemoteConfigSerivce {
  static FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  static Future<FirebaseRemoteConfig> init() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetchAndActivate();
    var configs = remoteConfig.getAll();
    if (configs["apiDaiLyXe"] != null) {
      CommonConfig.apiDaiLyXe = remoteConfig.getString("apiDaiLyXe");
    }
    if (configs["apiDaiLyXeSufix"] != null) {
      CommonConfig.apiDaiLyXeSufix = remoteConfig.getString("apiDaiLyXeSufix");
    }
    if (configs["apiRaoXe"] != null) {
      CommonConfig.apiRaoXe = remoteConfig.getString("apiRaoXe");
    }
    if (configs["apiRaoXeSufix"] != null) {
      CommonConfig.apiRaoXeSufix = remoteConfig.getString("apiRaoXeSufix");
    }
    if (configs["apiDrive"] != null) {
      CommonConfig.apiDrive = remoteConfig.getString("apiDrive");
    }
    if (configs["hostDynamicLink"] != null) {
      CommonConfig.hostDynamicLink =
          remoteConfig.getString("hostDynamicLink");
    }
    if (configs["hostRaoXe"] != null) {
      CommonConfig.hostRaoXe =
          remoteConfig.getString("hostRaoXe");
    }
    if (configs["version_masterdata"] != null) {
      CommonConfig.version_masterdata =
          int.parse(remoteConfig.getString("version_masterdata").toString());
    }
    return remoteConfig;
  }
}
