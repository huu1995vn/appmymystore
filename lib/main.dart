// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/models/app_theme.dart';
import 'package:raoxe/core/providers/theme_provider.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/services/theme_service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/pages/my_page.dart';

initializeApp() async {
  await StorageService.init();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //#to prevent my application from changing its orientation and force the layout
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        child: const MyPage(),
        builder: (c, themeProvider, home) => MaterialApp(
          color: Colors.transparent,
          debugShowCheckedModeBanner: false,
          theme: ThemeService.main(
          ),
          darkTheme: ThemeService.main(
            isDark: true,
          ).copyWith(
             colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
                .copyWith(
                    secondary: AppColors.primary, brightness: Brightness.dark),
          ),
          themeMode: themeProvider.selectedThemeMode,
          home: home,
        ),
      ),
    );
  }
}
