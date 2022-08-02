// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/providers/user_provider.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/services/info_device.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool authBiometric = false;
  _onBiometric(bool v) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
      link = Uri.decodeFull(uri.toString() + "&efr=1");
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

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    authBiometric =
        StorageService.get(StorageKeys.biometric) == userProvider.user.username;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(
              color: AppColors.black, //change your color here
            ),
            title: Text(
              'setting'.tr(),
              style: kTextHeaderStyle.copyWith(color: AppColors.black),
            ),
            centerTitle: true,
            backgroundColor: AppColors.grayDark,
            elevation: 0.0,
          ),
          SliverFillRemaining(
              child: Card(
                  child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        children: [
                          Expanded(
                              child: ListView(
                            shrinkWrap: true,
                            children: [
                              RxBuildItem(
                                  icon: Icon(AppIcons.sun),
                                  title: "Dark mode",
                                  trailing: Switch(
                                    value:
                                        theme.selectedThemeMode.name == "dark",
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
                                icon: const Icon(AppIcons.text_format),
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
                              ),
                              RxBuildItem(
                                  icon: const Icon(AppIcons.fingerprint),
                                  title: "Đăng nhập bằng sinh trắc học",
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
                              //     title: "Clear cache".tr(),
                              //     onTap: () {
                              //       RxSearchDelegate.cacheapiSearch = {};
                              //       CommonMethods.showToast(
                              //           context, "success".tr());
                              //     }),
                              RxBuildItem(
                                  icon: const Icon(AppIcons.share_1),
                                  title: "share".tr(),
                                  trailing: Icon(AppIcons.keyboard_arrow_right),
                                  onTap: _onShare),
                              RxBuildItem(
                                  title: "termsandcondition".tr(),
                                  onTap: () {
                                    CommonMethods.openWebViewTermsAndCondition(
                                        context);
                                  }),
                              RxBuildItem(
                                  title: "policy".tr(),
                                  onTap: () {
                                    CommonMethods.openWebViewPolicy(context);
                                  }),
                              RxBuildItem(
                                  title: "feedback".tr(),
                                  onTap: () {
                                    CommonMethods.openWebViewFeedBack(context);
                                  }),
                            ],
                          )),
                          RxRoundedButton(
                            title: 'logout'.tr(),
                            onPressed: () {
                              AuthService.logout(context);
                            },
                          ),
                          Text(
                            "${"version".tr()} ${InfoDeviceService.infoDevice.PackageInfo?.version.toLowerCase()}",
                            style: TextStyle().italic,
                          )
                        ],
                      ))))
        ],
      ),
    );
  }
}
