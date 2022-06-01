// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/core/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/utilities/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return
        RxScaffold(
            appBar: AppBar(
              title: Text('setting'.tr()),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            child: 
              RxWrapper(
                  body: Column(
                    children: [
                      RxBuildItem(
                          icon: const Icon(Icons.screen_share_rounded),
                          title: "Dark mode",
                          trailing: Switch(
                            value: theme.selectedThemeMode.name == "dark",
                            onChanged: (value) {
                              theme.enableDarkMode(value);
                            },
                            activeTrackColor: Colors.red[200],
                            activeColor: Colors.red,
                          ),
                          onTap: () {
                            // _authenticateWithBiometrics();
                          }),
                      RxBuildItem(
                          icon: const Icon(Icons.language),
                          title: context.locale.languageCode == "vi"
                              ? "Việt Nam"
                              : "English",
                          trailing: Switch(
                            value: context.locale.languageCode != "vi",
                            onChanged: (value) {
                              context.setLocale(value
                                  ? const Locale("en")
                                  : const Locale("vi"));
                            },
                            activeTrackColor: Colors.red[200],
                            activeColor: Colors.red,
                          ),
                          onTap: () {
                            // _authenticateWithBiometrics();
                          }),
                    ],
                  ),
                ),
            );
  }
}
