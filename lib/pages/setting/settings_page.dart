// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/delegates/rx_search.delegate.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/core/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/services/api_token.service.dart';
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
    bool authBiometric = await AuthService.authBiometric();
    if (!authBiometric) {
      CommonMethods.showToast("Thao tác thất bại");
    }
    if (v) {
      await StorageService.set(StorageKeys.biometrics, APITokenService.token);
    } else {
      StorageService.deleteItem(StorageKeys.biometrics);
    }
    setState(() {
      authBiometric = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
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
                              RxBuildItem(
                                  title: "Clear cache".tr(),
                                  onTap: () {
                                    RxSearchDelegate.cacheapiSearch = {};
                                    CommonMethods.showToast("Đã xóa cache");
                                  }),
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
                            style: TextStyle().italic.size(12),
                          )
                        ],
                      ))))
        ],
      ),
      
    );
  }
}
