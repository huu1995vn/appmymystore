// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:provider/provider.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/lang/translation.service.dart';
import 'package:mymystore/core/providers/app_provider.dart';
import 'package:mymystore/core/services/info_device.service.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:mymystore/core/theme/theme.service.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/utilities/extensions.dart';

class SettingsPage extends StatefulWidget {
  static String route() => '/setting';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLang = TranslationService.locale!.languageCode;
  bool authBiometric = false;
  _onBiometric(bool v) async {
    // final userProvider = Provider.of<AppProvider>(context, listen: false);
    // try {
    //   var res = await AuthService.authBiometric();
    //   if (v && res) {
    //     await StorageService.set(
    //         StorageKeys.biometric, userProvider.user.phone);
    //     setState(() {
    //       authBiometric = true;
    //     });
    //     CommonMethods.showToast("success".tr);
    //   } else {
    //     StorageService.deleteItem(StorageKeys.biometric);
    //     setState(() {
    //       authBiometric = false;
    //     });
    //   }
    // } catch (e) {
    //   CommonMethods.showDialogError(context, e);
    // }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadData() async {}

  List<DropdownMenuItem<String>> _buildDropdownLangs() {
    var list = <DropdownMenuItem<String>>[];
    TranslationService.langs.forEach((key, value) {
      list.add(DropdownMenuItem<String>(
        value: key,
        child: Text(value),
      ));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<AppProvider>(context, listen: true);
    authBiometric =
        StorageService.get(StorageKeys.biometric) == userProvider.user.phone;

    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.tr),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
              child: Column(
            children: [
              Card(
                  margin: EdgeInsets.only(top: 6, bottom: 6),
                  child: ListView(
                    shrinkWrap: true,
                    children: ListTile.divideTiles(
                      //          <-- ListTile.divideTiles
                      context: context,
                      tiles: [
                        MMBuildItem(
                            icon: Icon(AppIcons.sun),
                            title: "darkmode".tr,
                            trailing: Switch(
                              value: ThemeService().isSavedDarkMode(),
                              onChanged: (value) {
                                setState(() {
                                  ThemeService().changeThemeMode();
                                });
                              },
                              activeTrackColor: Colors.red[200],
                              activeColor: Colors.red,
                            ),
                            onTap: () {
                              // _authenticateWithBiometrics();
                            }),
                        MMBuildItem(
                          icon: const Icon(AppIcons.language_1),
                          title: "language".tr,
                          trailing: DropdownButton<String>(
                            icon: Icon(Icons.arrow_drop_down),
                            value: _selectedLang,
                            items: _buildDropdownLangs(),
                            onChanged: (value) {
                              setState(() => _selectedLang = value!);
                              TranslationService.changeLocale(value!);
                            },
                          ),
                        ),
                        if (APITokenService.isLogin)
                          MMBuildItem(
                              icon: const Icon(AppIcons.fingerprint),
                              title: "login.biometrics".tr,
                              trailing: Switch(
                                value: authBiometric,
                                onChanged: _onBiometric,
                                activeTrackColor: Colors.red[200],
                                activeColor: Colors.red,
                              ),
                              onTap: () {
                                // _authenticateWithBiometrics();
                              }),
                        // MMBuildItem(
                        //     title: "Clear cache".tr,
                        //     onTap: () {
                        //       MMSearchDelegate.cacheapiSearch = {};
                        //       CommonMethods.showToast(
                        //           context, "success".tr);
                        //     }),

                        MMBuildItem(
                            title: "termsandcondition".tr,
                            onTap: () {
                              openWebViewTermsAndCondition(context);
                            }),
                        MMBuildItem(
                            title: "policy".tr,
                            onTap: () {
                              openWebViewPolicy(context);
                            }),
                        MMBuildItem(
                            title: "feedback".tr,
                            onTap: () {
                              openWebViewFeedBack(context);
                            }),
                      ],
                    ).toList(),
                  )),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.all(CommonConstants.kDefaultPadding),
                child: Text(
                  "${"version".tr} ${InfoDeviceService.infoDevice.PackageInfo?.version.toLowerCase()}",
                  style: TextStyle().italic,
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Future<T?> openWebViewTermsAndCondition<T>(context) async {
    return CommonMethods.openWebView(context,
        url: CommonConfig.LinkContent["dieuKhoan"].toString(),
        title: "termsandcondition".tr);
  }

  Future<T?> openWebViewPolicy<T>(context) async {
    return CommonMethods.openWebView(context,
        url: CommonConfig.LinkContent["chinhSach"].toString(),
        title: "policy".tr);
  }

  Future<T?> openWebViewFeedBack<T>(context) async {
    return CommonMethods.openWebView(context,
        url: CommonConfig.LinkContent["feedBack"].toString(),
        title: "feedback".tr);
  }
}
