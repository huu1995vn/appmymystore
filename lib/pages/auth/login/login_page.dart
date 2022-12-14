// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/index.dart';
import 'package:mymystore/core/components/part.dart';
import 'package:mymystore/core/providers/app_provider.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/auth.service.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/utilities/extensions.dart';
import 'package:mymystore/pages/home/home.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
    userlogin = StorageService.get(StorageKeys.userlogin) ?? {};
    setState(() {
      if (userlogin != null && !userlogin.isEmpty) {
        username = userlogin["username"];
      }
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
      backgroundColor: Get.isDarkMode ? Colors.black54 : AppColors.white,
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
          const SizedBox(height: 30),
          Text(
            "login".tr.toUpperCase(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "welcome".tr,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(CommonConstants.kDefaultPadding * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black26)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black26))),
                        child: MMInput(
                          username,
                          labelText: "phone".tr,
                          icon: const Icon(AppIcons.phone_1),
                          keyboardType: TextInputType.number,
                          onChanged: (v) => {username = v},
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: MMInput(
                            password,
                            isPassword: true,
                            labelText: "password".tr,
                            icon: const Icon(AppIcons.lock_1),
                            onChanged: (v) => {password = v},
                          )),
                    ],
                  ),
                ))),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
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
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: MMPrimaryButton(
                        onTap: () {
                          _onLogin(username, password);
                        },
                        text: "login".tr.toUpperCase())),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Ink(
                  height: CommonConstants.kSizeHeight,
                  decoration: const ShapeDecoration(
                    color: AppColors.grayDark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  child: IconButton(
                    // iconSize: 59,
                    icon: const Icon(AppIcons.fingerprint),
                    color: AppColors.black50,
                    onPressed: _onLoginBiometric,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            _createAccountLabel(context)
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
              "message.str005".tr,
            ),
            Text(
              "regist".tr,
              style: const TextStyle(color: AppColors.primary).bold,
            ),
          ],
        ),
      ),
    );
  }

  _onLoginBiometric() async {
    try {
      if (!CommonMethods.checkStringPhone(username)) {
        throw "invalid.phone".tr;
      }
      String userbio = StorageService.get(StorageKeys.biometric);
      isLoginBio = userbio == username;
      if (isLoginBio && userlogin != null) {
        // await AuthService.authBiometric();
        // _onLogin(username, userlogin["password"]!);
      } else {
        throw "message.str011".tr;
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
      var uri = Uri.https('mymystore.azurewebsites.net', '/api/user/checkapi');
      var response = await http.get(uri);

      // // await AuthService.checkPhone(username, isExist: true);
      // if (mounted) {
      //   var res = await AuthService.login(context, username, password);
      //   if (res) {
      //     Provider.of<AppProvider>(context).setUserModel(APITokenService.user);
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(
      //             builder: (BuildContext context) => const HomeScreen()),
      //         (Route<dynamic> route) => route.isFirst);
      //   }
      // }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
    CommonMethods.unlockScreen();
  }
}
