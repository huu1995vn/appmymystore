// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/api/api.bll.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/dialogs/phone_auth.dailog.dart';
import 'package:mymystore/core/components/index.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/auth.service.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/utilities/extensions.dart';
import 'package:http/http.dart' as http;
import 'package:mymystore/pages/home/home.page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> keyLogin = GlobalKey<FormState>();
  String username = "";
  String password = "";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool isLoginBio = false;
  Map<String, dynamic> userlogin = {};

  loadData() {
    setState(() {
      username = StorageService.getUserLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: keyLogin,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness:
              Get.isDarkMode ? Brightness.light : Brightness.dark,
          statusBarBrightness:
              Get.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        iconTheme: IconThemeData(
          color: Get.isDarkMode
              ? AppColors.white
              : AppColors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      // backgroundColor: Get.isDarkMode ? Colors.black54 : AppColors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        _header(),
        _body(),
      ]),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
      child: Column(
        children: [
          Image.asset(
            CommonConstants.IMAGE_LOGO,
            width: 180,
          ),
          MMText(
            data: "login".tr.toUpperCase(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: CommonConstants.kDefaultMargin,
          ),
          MMText(
            data: "welcome".tr,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  MMInput(
                    username,
                    hintText: "phone".tr,
                    icon: const Icon(AppIcons.phone_1),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => {username = v},
                  ),
                  const SizedBox(height: CommonConstants.kDefaultPadding),
                  MMInput(
                    password,
                    isPassword: true,
                    hintText: "password".tr,
                    icon: const Icon(AppIcons.lock_1),
                    onChanged: (v) => {password = v},
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:
                      const EdgeInsets.all(CommonConstants.kDefaultPadding),
                  child: GestureDetector(
                      onTap: _onForgotPassword,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'forgot.password'.tr,
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )),
                )),
            const SizedBox(height: CommonConstants.kDefaultMargin),
            Row(
              children: [
                Expanded(
                    child: MMPrimaryButton(
                        onTap: () {
                          _onLogin(username, password);
                        },
                        text: "login".tr.toUpperCase())),
              ],
            ),
            const SizedBox(height: 30),
            _createAccountLabel(context),
            const SizedBox(height: 30),
            if (CommonConfig.IsBiometricSupported)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Ink(
                      height: CommonConstants.kSizeHeight * 2,
                      width: CommonConstants.kSizeHeight * 2,
                      decoration: const ShapeDecoration(
                        color: AppColors.grayDark,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                CommonConstants.kDefaultRadius))),
                      ),
                      child: IconButton(
                        iconSize: 59,
                        icon: const Icon(AppIcons.fingerprint),
                        color: AppColors.black50,
                        onPressed: _onLoginBiometric,
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

  _toRegister() async {
    String phone = await CommonNavigates.openDialog(
        context, PhoneAuthDialog(isExist: false, title: "regist.phone".tr));
    if (phone.isNotNullEmpty) {
      CommonNavigates.toRegisterPage(context, phone);
    }
  }

  Widget _createAccountLabel(context) {
    return GestureDetector(
      onTap: _toRegister,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MMText(
              data: "message.str005".tr,
            ),
            MMText(
              data: "regist".tr,
              style: const TextStyle(color: AppColors.primary).bold,
            ),
          ],
        ),
      ),
    );
  }

  _onLoginBiometric() async {
    String token = StorageService.getTokenBiometric();
    if (token == null || token.isNullEmpty) {
      CommonMethods.showToast("message.str011".tr);
      return;
    }
    try {
      var res = await AuthService.authBiometric();
      if (res) {
        CommonMethods.lockScreen();
        var res = await ApiBLL_APIToken().refreshlogin(token);
        if (res.status > 0) {
          APITokenService.token = res.data;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()),
              (Route<dynamic> route) => route.isFirst);
        } else {
          CommonMethods.showToast(res.message);
        }
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
    CommonMethods.unlockScreen();
  }

  _onForgotPassword() async {
    String phone = await CommonNavigates.openDialog(
        context, PhoneAuthDialog(isExist: true, title: "forgot.password".tr));
    if (phone.isNotNullEmpty) {
      CommonNavigates.toForgotPasswordPage(context, phone);
    }
  }

  _onLogin(String username, String password) async {
    CommonMethods.lockScreen();
    try {
      // await AuthService.checkPhone(username, isExist: true);
      if (mounted) {
        var res = await AuthService.login(context, username, password);
        if (res) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()),
              (Route<dynamic> route) => route.isFirst);
        }
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }

    CommonMethods.unlockScreen();
  }
}
