import 'package:raoxe/enviroments/prod.dart';
import 'package:raoxe/enviroments/dev.dart';

enum Environment {
  dev,
  prod,
}

class CommonConfig {
  //system
  static Map deviceInfo = {};
  static String env = "dev";
  static String apiHostDaiLyXe = "http://api.dailyxe.info";
  static String apiHostSufixDaiLyXe = "/";
  static String apiHostRaoXe = "https://raoxe.dailyxe.info";
  static String apiHostSufixRaoXe = "/";
  static String apiDrive = "http://cdn.dailyxe.info";

  static String uriPrefixDynamicLink = "https://raoxe.page.link";
  static String appStoreID = "1486119532";

  static late Map<String, dynamic> _config;
  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = configDev;
        break;
      case Environment.prod:
        _config = configProd;
        break;
    }
    CommonConfig.env = _config["env"];
    CommonConfig.apiHostDaiLyXe =
        _config["apiHostDaiLyXe"] ?? CommonConfig.apiHostDaiLyXe;
    CommonConfig.apiHostSufixDaiLyXe =
        _config["apiHostSufixDaiLyXe"] ?? CommonConfig.apiHostSufixDaiLyXe;
    CommonConfig.apiHostRaoXe =
        _config["apiHostRaoXe"] ?? CommonConfig.apiHostRaoXe;
    CommonConfig.apiHostSufixRaoXe =
        _config["apiHostSufixRaoXe"] ?? CommonConfig.apiHostSufixRaoXe;
    CommonConfig.apiDrive = _config["apiDrive"] ?? CommonConfig.apiDrive;
  }
}
