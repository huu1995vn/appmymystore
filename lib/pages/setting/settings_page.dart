import 'package:flutter/material.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/pages/setting/components/theme_switcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: RxWrapper(
        body: Column(
          children: const [
            SizedBox(height: 30),
            ThemeSwitcher(),
          ],
        ),
      ),
    );
  }
}
