import 'package:mymystore/core/commons/common_configs.dart';
import 'main.dart';

void main() async {
  CommonConfig.setEnvironment(Environment.dev);
  await init();
}