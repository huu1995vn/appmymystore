// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/providers/theme_provider.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/firebase/firebase_messaging_service.dart';
import 'package:raoxe/core/services/info_device.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/services/theme.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/custom_animation.dart';
import 'package:raoxe/pages/my_page.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:upgrader/upgrader.dart';

//#test
init() async {
  await initializeApp();
  configLoading();

  return runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('vi')],
        path:
            'assets/translations', // <-- change the path of the translation files
        child: const MyApp()),
  );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    // ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
    
}

initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InfoDeviceService.init();
  await StorageService.init();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await FirebaseMessagingService.init();
  APITokenService.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appcastURL =
        'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

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
        child: UpgradeAlert(
            upgrader: Upgrader(
                appcastConfig: cfg, showIgnore: false, showLater: false),
            child: const MyPage()),
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
          routes: CommonNavigates.routers,
          builder: EasyLoading.init(),
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
