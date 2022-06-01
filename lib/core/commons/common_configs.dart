import 'package:raoxe/core/models/app_theme.dart';
import 'package:raoxe/enviroments/prod.dart';
import 'package:raoxe/enviroments/dev.dart';

enum Environment {
  dev,
  prod,
}

class CommonConfig {
  static String env = "dev";
  static String apiHost = "https://docker.dailyxe.com.vn";
  static String apiHostSufix = "/raoxe/api/dailyxe/";
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
    CommonConfig.env = _config["env"] ?? CommonConfig.apiHost;
    CommonConfig.apiHost = _config["apiHost"] ?? CommonConfig.apiHost;
    CommonConfig.apiHostSufix =
        _config["apiHostSufix"] ?? CommonConfig.apiHostSufix;
  }
}
