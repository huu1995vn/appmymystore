class CommonConfig {
  static String apiHost = "https://docker.dailyxe.com.vn";
  static String apiHostSufix = "/raoxe/api/dailyxe/";
  static init(dynamic config) {
    CommonConfig.apiHost = config["apiHost"] ?? CommonConfig.apiHost;
    CommonConfig.apiHostSufix =
        config["apiHostSufix"] ?? CommonConfig.apiHostSufix;
  }
}
