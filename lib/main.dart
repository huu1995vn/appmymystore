// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/providers/theme_provider.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/services/theme_service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/pages/my_page.dart';
import 'package:splashscreen/splashscreen.dart';

//#test
initializeApp() async {
  await StorageService.init();
  return runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('vi')],
        path:
            'assets/translations', // <-- change the path of the translation files
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          color: Colors.transparent,
          debugShowCheckedModeBanner: false,
          theme: ThemeService.main(),
          darkTheme: ThemeService.main(
            isDark: true,
          ).copyWith(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
                .copyWith(
                    secondary: AppColors.primary, brightness: Brightness.dark),
          ),
          themeMode: themeProvider.selectedThemeMode,
          home: SplashScreen(
            seconds: 3,
            navigateAfterSeconds: home,
            imageBackground: const AssetImage('assets/splash.png'),
            loaderColor: Colors.red,
          ),
          // routes: CommonNavigates.defaulRoutes,
        ),
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {
  const AfterSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Welcome In SplashScreen Package"),
          automaticallyImplyLeading: false),
      body: const Center(
        child: Text(
          "Done!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }
}
