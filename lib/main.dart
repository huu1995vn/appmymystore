// ignore_for_file: import_of_legacy_library_into_null_safe, empty_catches

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/commons/flutter_app_version_checker.dart';
import 'package:mymystore/core/lang/translation.service.dart';
import 'package:mymystore/core/providers/app_provider.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/firebase/cloud_firestore.service.dart';
import 'package:mymystore/core/services/firebase/firebase_auth.service.dart';
import 'package:mymystore/core/services/firebase/firebase_messaging_service.dart';
import 'package:mymystore/core/services/firebase/remote_config.service.dart';
import 'package:mymystore/core/services/info_device.service.dart';
import 'package:mymystore/core/services/master_data.service.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:mymystore/core/theme/theme.service.dart';
import 'package:mymystore/core/theme/themes.dart';
import 'package:mymystore/core/utilities/logger_utils.dart';
import 'package:mymystore/screens/error/error_page.dart';
import 'package:mymystore/screens/update/update_page.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

//#test
init() async {
  await initializeApp();
  configLoading();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    // Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(const HomeScreen());
  });
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
  await StorageService.init();
  await Firebase.initializeApp();

  //very important
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final newVersion = AppVersionChecker();
  @override
  void initState() {
    super.initState();
  }


  Future<Widget> loadFromFuture(Widget? main) async {
    try {
      var status = await newVersion.checkUpdate();
      if (status != null && status.canUpdate) {
        return UpdatePage(data: status);
      }
      await InfoDeviceService.init();
      await FirebaseAuthService.signInAnonymously();
      await FirebaseMessagingService.init();
      APITokenService.init();
      await CloudFirestoreSerivce.init();
      bool res = await MasterDataService.init();
      if (res) {
        return main!;
      }
    } catch (e) {
      CommonMethods.wirtePrint(e.toString());
    }
    return ErrorPage(message: "message.alert03".tr);
  }

  @override
  Widget build(BuildContext context) {
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
          child: const HomeScreen(),
          builder: (c, appProvider, home) => OverlaySupport(
                child: GetMaterialApp(
                  color: Colors.transparent,
                  home: FutureBuilder<FirebaseRemoteConfig>(
                    future: RemoteConfigSerivce.init(),
                    builder: (BuildContext context,
                        AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
                      return (snapshot.hasData)
                          ? SplashScreen(
                              seconds: 3,
                              navigateAfterFuture: loadFromFuture(home),
                              imageBackground:
                                  const AssetImage('assets/splash.png'),
                              loaderColor: Colors.red,
                            )
                          : const Scaffold(
                              body: Image(
                                  image: AssetImage('assets/splash.png'),
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                  alignment: Alignment.center),
                            );
                    },
                  ),
                  routes: CommonNavigates.routers,
                  builder: EasyLoading.init(),
                  debugShowCheckedModeBanner: false,
                  enableLog: true,
                  logWriterCallback: Logger.write,
                  // initialRoute: AppPages.INITIAL,
                  // getPages: AppPages.routes,
                  // ignore: prefer_const_literals_to_create_immutables
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate
                  ],
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
