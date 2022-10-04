// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:raoxe/pages/auth/confirm_otp_page.dart';
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
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 32.0),
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
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              LOGORAOXECOLORIMAGE,
              width: 180,
            ),
            const SizedBox(height: 30),
            Text(
              "forgot.password".tr,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Form(
            key: _keyValidationForm,
            child: Container(
                margin: const EdgeInsets.only(bottom: 20),
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
                      child: RxInput(phone,
                          keyboardType: TextInputType.number,
                          labelText: "phone".tr,
                          icon: const Icon(AppIcons.phone_handset),
                          onChanged: (v) => {
                                setState(() => {phone = v})
                              },
                          validator: (v) {
                            if (v == null || !v.isNotEmpty) {
                              return "notempty.phone.text".tr;
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
                      child: RxInput(password,
                          isPassword: true,
                          labelText: "password.new".tr,
                          icon: const Icon(AppIcons.lock_1),
                          onChanged: (v) => {
                                setState(() => {password = v})
                              },
                          validator: Validators.compose([
                            Validators.required("notempty.password.text".tr),
                          ])),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: RxInput(passwordAgain,
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
                )),
          ),
          Row(children: [
            Expanded(
              child: RxPrimaryButton(
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
          RxLoginAccountLabel(context)
        ]),
      ),
    );
  }

  //#endregion
  //#fuction main
  Future onForgotPassword() async {
    try {
      await AuthService.checkPhone(phone, isExist: true);
      bool checkOtp =
          await CommonNavigates.openOtpVerificationDialog(context, phone, true);
      if (checkOtp != null && checkOtp) {
        var res =
            await DaiLyXeApiBLL_APIAnonymous().forgotpassword(phone, password);
        if (res.status > 0) {
          CommonMethods.showToast("success".tr);
        } else {
          CommonMethods.showToast(res.message);
        }
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }
  //#end function main
}
