// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/lang/translation.service.dart';
import 'package:raoxe/core/providers/app_provider.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/services/info_device.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/theme/theme.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import '../../core/commons/common_configs.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLang = TranslationService.locale!.languageCode;
  bool authBiometric = false;
  _onBiometric(bool v) async {
    final userProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      await AuthService.authBiometric();
      if (v) {
        await StorageService.set(
            StorageKeys.biometric, userProvider.user.username);
      } else {
        StorageService.deleteItem(StorageKeys.biometric);
      }
      setState(() {
        authBiometric = v;
      });
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
  }

  late String link;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadData() async {
    String linkDeepLinkInstallWithDomain =
        CommonMethods.deepLinkInstallWithDomain();
    Uri uri =
        await CommonMethods.createDynamicLink(linkDeepLinkInstallWithDomain);
    setState(() {
      link = Uri.decodeFull("$uri&efr=1");
    });
  }

  _onShare() async {
    CommonMethods.lockScreen();
    try {
      if (link.isNotNullEmpty) {
        await CommonMethods.share(link);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
    CommonMethods.unlockScreen();
  }

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
    var userProvider = Provider.of<AppProvider>(context);
    authBiometric =
        StorageService.get(StorageKeys.biometric) == userProvider.user.username;

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
              Container(
                  color:
                      CommonConfig.isDark ? AppColors.blackLight : Colors.white,
                  margin: EdgeInsets.only(top: 6, bottom: 6),
                  child: ListView(
                    shrinkWrap: true,
                    children: ListTile.divideTiles(
                      //          <-- ListTile.divideTiles
                      context: context,
                      tiles: [
                        RxBuildItem(
                            icon: FaIcon(FontAwesomeIcons.sun),
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
                        RxBuildItem(
                          icon: const Icon(AppIcons.text_format),
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

                        RxBuildItem(
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
                        // RxBuildItem(
                        //     title: "Clear cache".tr,
                        //     onTap: () {
                        //       RxSearchDelegate.cacheapiSearch = {};
                        //       CommonMethods.showToast(
                        //           context, "success".tr);
                        //     }),
                        RxBuildItem(
                            icon:
                                const FaIcon(FontAwesomeIcons.shareFromSquare),
                            title: "share".tr,
                            trailing: Icon(AppIcons.keyboard_arrow_right),
                            onTap: _onShare),
                        RxBuildItem(
                            title: "termsandcondition".tr,
                            onTap: () {
                              CommonMethods.openWebViewTermsAndCondition(
                                  context);
                            }),
                        RxBuildItem(
                            title: "policy".tr,
                            onTap: () {
                              CommonMethods.openWebViewPolicy(context);
                            }),
                        RxBuildItem(
                            title: "feedback".tr,
                            onTap: () {
                              CommonMethods.openWebViewFeedBack(context);
                            }),
                      ],
                    ).toList(),
                  )),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.all(10),
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
}
