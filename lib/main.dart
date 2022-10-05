// ignore_for_file: import_of_legacy_library_into_null_safe, empty_catches

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/lang/translation.service.dart';
import 'package:raoxe/core/providers/app_provider.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/services/firebase/cloud_firestore.service.dart';
import 'package:raoxe/core/services/firebase/firebase_auth.service.dart';
import 'package:raoxe/core/services/firebase/firebase_messaging_service.dart';
import 'package:raoxe/core/services/firebase/remote_config.service.dart';
import 'package:raoxe/core/services/info_device.service.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/theme/theme.service.dart';
import 'package:raoxe/core/theme/themes.dart';
import 'package:raoxe/core/utilities/logger_utils.dart';
import 'package:raoxe/pages/my_page.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

//#test
init() async {
  await initializeApp();
  configLoading();
  return runApp(
    const MyApp(),
  );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.light
    // ..maskType = EasyLoadingMaskType.black
    // ..indicatorSize = 45.0
    // ..radius = 10.0
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await StorageService.init();
  await InfoDeviceService.init();
  await Firebase.initializeApp();
  await FirebaseAuthService.signInAnonymously();
  await FirebaseMessagingService.init();
  APITokenService.init();
  await AuthService.autologin();
  await CloudFirestoreSerivce.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> loadFromFuture(Widget? main) async {
    try {
      bool res = await MasterDataService.init();
      if (res) {
        return main!;
      }
    } catch (e) {}
    return main!; //const ErrorPage(message: "Vui lòng trở lại sau");
  }

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
          create: (_) => AppProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppProvider(),
        ),
      ],
      child: Consumer<AppProvider>(
          child: const MyPage(),
          builder: (c, appProvider, home) => OverlaySupport(
                child: GetMaterialApp(
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  color: Colors.transparent,
                  // debugShowCheckedModeBanner: false,
                  // theme: ThemeService.main(),
                  // darkTheme: ThemeService.main(
                  //   isDark: true,
                  // ).copyWith(
                  //   colorScheme:
                  //       ColorScheme.fromSwatch(primarySwatch: Colors.red)
                  //           .copyWith(
                  //               secondary: AppColors.primary,
                  //               brightness: Brightness.dark),
                  // ),
                  // themeMode: themeProvider.selectedThemeMode,
                  home: FutureBuilder<FirebaseRemoteConfig>(
                    future: RemoteConfigSerivce.init(),
                    builder: (BuildContext context,
                        AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
                      return snapshot.hasData
                          ? SplashScreen(
                              navigateAfterFuture: loadFromFuture(home),
                              imageBackground:
                                  const AssetImage('assets/splash.png'),
                              loaderColor: Colors.red,
                            )
                          : Container();
                    },
                  ),
                  routes: CommonNavigates.routers,
                  builder: EasyLoading.init(),
                  debugShowCheckedModeBanner: false,
                  enableLog: true,
                  logWriterCallback: Logger.write,
                  // initialRoute: AppPages.INITIAL,
                  // getPages: AppPages.routes,
                  supportedLocales: TranslationService.locales,
                  locale: TranslationService.locale,
                  fallbackLocale: TranslationService.fallbackLocale,
                  translations: TranslationService(),
                  theme: Themes.lightTheme,
                  darkTheme: Themes.darkTheme,
                  themeMode: ThemeService().getThemeMode(),
                ),
              )),
    );
  }
}
