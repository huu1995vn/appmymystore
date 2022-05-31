import 'package:raoxe/flavour_config.dart';
import 'package:raoxe/main.dart';

void main() async {
  Constants.setEnvironment(Environment.dev);
  await initializeApp();
}