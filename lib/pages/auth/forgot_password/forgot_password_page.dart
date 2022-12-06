// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/components/index.dart';
import 'package:mymystore/core/components/part.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:wc_form_validators/wc_form_validators.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  String phone = "";
  String password = "";
  String passwordAgain = "";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                _header(),
                _body(),
              ],
            )),
      ),
    );
  }

  //#region widgets private
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              CommonConstants.IMAGE_LOGO,
              width: 180,
            ),
            const SizedBox(height: 30),
            Text(
              "forgot.password".tr.toUpperCase(),
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: <Widget>[
        Form(
          key: _keyValidationForm,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
                        child: MMInput(phone,
                            keyboardType: TextInputType.number,
                            labelText: "phone".tr,
                            icon: const Icon(AppIcons.phone_1),
                            onChanged: (v) => {
                                  setState(() => {phone = v})
                                },
                            validator: (v) {
                              if (v == null || !v.isNotEmpty) {
                                return "notempty.phone".tr;
                              } else {
                                return CommonMethods.checkStringPhone(v)
                                    ? null
                                    : "invalid.phone".tr;
                              }
                            }),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black26))),
                        child: MMInput(password,
                            isPassword: true,
                            labelText: "password.new".tr,
                            icon: const Icon(AppIcons.lock_1),
                            onChanged: (v) => {
                                  setState(() => {password = v})
                                },
                            validator: Validators.compose([
                              Validators.required("notempty.password".tr),
                            ])),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: MMInput(passwordAgain,
                            isPassword: true,
                            labelText: "password.again".tr,
                            icon: const Icon(AppIcons.lock_1),
                            validator: (value) {
                          if (value != null && value != password) {
                            return "invalid.password.again".tr;
                          } else {
                            return null;
                          }
                        }),
                      ),
                    ],
                  ))),
        ),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
            child: MMPrimaryButton(
                onTap: () {
                  if (_keyValidationForm.currentState!.validate()) {
                    onForgotPassword();
                  }
                },
                text: 'continue'.tr),
          )
        ]),
        const SizedBox(
          height: 20,
        ),
        //button: login
        MMLoginAccountLabel(context)
      ]),
    );
  }

  //#endregion
  //#fuction main
  Future onForgotPassword() async {
    try {
      // await AuthService.checkPhone(phone, isExist: true);
      // bool checkOtp = await CommonNavigates.openOtpVerificationPhoneDialog(
      //     context, phone, true);
      // if (checkOtp != null && checkOtp) {
      //   var res = await ApiBLL_APIAnonymous().forgotpassword(phone, password);
      //   if (res.status > 0) {
      //     CommonNavigates.toLoginPage(context);
      //     CommonMethods.showToast("success".tr);
      //   } else {
      //     CommonMethods.showToast(res.message);
      //   }
      // }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }
  //#end function main
}
