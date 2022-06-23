// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/dialogs/confirm_phone.dialog.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';

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

  String? tokenbiometrics;
  dynamic usl;
  loadData() {
    setState(() {
      tokenbiometrics = StorageService.get(StorageKeys.biometrics);
      usl = StorageService.get(StorageKeys.userlogin);
      if (usl != null) username = usl!["username"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
        key: keyLogin,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_header(), _body()]));
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          Image.asset(
            LOGORAOXEWHITEIMAGE,
            width: 150,
          ),
          const Text(
            'Welcome to back',
            style: TextStyle(
              color: AppColors.white,
              // fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
        child: RxWrapper(
            body: SingleChildScrollView(
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
                          icon: const Icon(Icons.phone),
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
                            icon: const Icon(Icons.lock),
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
            _createAccountLabel(context),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Ink(
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.teal,
                ),
                child: IconButton(
                  iconSize: 59,
                  icon: const Icon(Icons.fingerprint),
                  color: AppColors.black50,
                  onPressed: _onLoginBiometrics,
                ),
              ),
            ))
          ],
        ),
      ),
    )));
  }

  _toRegister() async {
    var phone = await showDialog(
        context: context,
        builder: (_) => const ConfirmPhoneDialog(
              isExist: false,
            ));
    if (phone != null) {
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

  _onLoginBiometrics() async {
    if (tokenbiometrics == null || usl == null) {
      CommonMethods.showToast("Chức năng này chưa bật");
    } else {
      bool authBiometric = await AuthService.authBiometric();
      if (!authBiometric) {
        CommonMethods.showToast("Thiết bị không khả dụng");
      }
      _onLogin(username, usl!["password"]!);
    }
  }
  _onForgotPassword() async {
    var phone = await showDialog(
        context: context,
        builder: (_) => const ConfirmPhoneDialog(
              isExist: true,
            ));
    if (phone != null) {
      CommonNavigates.toForgotPasswordPage(context, phone);
    }
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
