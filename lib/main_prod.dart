import 'package:flutter/material.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/main.dart';

void main() async {
  CommonConfig.setEnvironment(Environment.prod);
  WidgetsFlutterBinding.ensureInitialized();
  await init();
}