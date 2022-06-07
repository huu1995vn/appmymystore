import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/main.dart';

void main() async {
  CommonConfig.setEnvironment(Environment.dev);
  await init();
}