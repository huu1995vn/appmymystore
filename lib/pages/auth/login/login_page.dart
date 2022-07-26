// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/utilities/extensions.dart';

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
    userlogin = StorageService.get(StorageKeys.userlogin);
    setState(() {
      if (userlogin != null) {
        username = userlogin["username"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyLogin,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _header(),
        _body(),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: _createAccountLabel(context),
          ),
        ),
      ]),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          Image.asset(
            LOGORAOXECOLORIMAGE,
            width: 150,
          ),
          Text(
            'Welcome to back',
            style: const TextStyle().italic,
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(225, 95, 27, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10))
                    ]),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: AppColors.grey))),
                        child: RxInput(
                          username,
                          labelText: "phone".tr(),
                          icon: const Icon(AppIcons.phone_handset),
                          keyboardType: TextInputType.number,
                          onChanged: (v) => {username = v},
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: AppColors.grey))),
                          child: RxInput(
                            password,
                            isPassword: true,
                            labelText: "password.text".tr(),
                            icon: const Icon(AppIcons.lock_1),
                            onChanged: (v) => {password = v},
                          )),
                    ],
                  ),
                )),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: _onForgotPassword,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'forgot.password'.tr(),
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )),
                )),
            RxPrimaryButton(
                onTap: () {
                  _onLogin(username, password);
                },
                text: "continue".tr().toUpperCase()),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: IconButton(
                iconSize: 59,
                icon: const Icon(AppIcons.fingerprint),
                color: AppColors.black50,
                onPressed: _onLoginBiometric,
              ),
            )),

            // ,
          ],
        ),
      ),
    );
  }

  _toRegister() async {
    CommonNavigates.toRegisterPage(context);
  }

  Widget _createAccountLabel(context) {
    return GestureDetector(
      onTap: _toRegister,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "message.str036".tr(),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Text(
              "registnow".tr(),
              style: const TextStyle(
                  color: AppColors.primary500,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  _onLoginBiometric() async {
    try {
      String userbio = StorageService.get(StorageKeys.biometric);
      isLoginBio = userbio == username;
      if (!isLoginBio && userlogin == null) {
        CommonMethods.showToast(context, "message.str046".tr());
      } else {
        await AuthService.authBiometric();
        _onLogin(username, userlogin["password"]!);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
  }

  _onForgotPassword() async {
    CommonNavigates.toForgotPasswordPage(context);
  }

  _onLogin(String username, String password) async {
    CommonMethods.lockScreen();
    try {
      await AuthService.checkPhone(username, isExist: true);
      if (mounted) await AuthService.login(context, username, password);
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }

    CommonMethods.unlockScreen();
  }
}
