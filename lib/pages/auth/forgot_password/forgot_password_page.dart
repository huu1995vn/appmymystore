// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: SingleChildScrollView(
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
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              LOGORAOXEWHITEIMAGE,
              width: 150,
            ),
            Text("forgot.password".tr(),
                style: const TextStyle(color: AppColors.white))
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _keyValidationForm,
            child: Column(
              children: <Widget>[
                RxInput(phone,
                    keyboardType: TextInputType.number,
                    labelText: "phone".tr(),
                    icon: const Icon(Icons.phone),
                    onChanged: (v) => {
                          setState(() => {phone = v})
                        },
                    validator: (v) {
                      if (v == null || !v.isNotEmpty) {
                        return "notempty.phone.text".tr();
                      } else {
                        return CommonMethods.checkStringPhone(v)
                            ? null
                            : "invalid.phone".tr();
                      }
                    }),
                RxInput(password,
                    isPassword: true,
                    labelText: "password.new".tr(),
                    icon: const Icon(Icons.lock),
                    onChanged: (v) => {
                          setState(() => {password = v})
                        },
                    validator: Validators.compose([
                      Validators.required("notempty.password.text".tr()),
                      // Validators.patternString(
                      //     RxParttern.password, "message.str017".tr())
                    ])),
                RxInput(passwordAgain,
                    isPassword: true,
                    labelText: "password.again".tr(),
                    icon: const Icon(Icons.lock), validator: (value) {
                  if (value != null && value != password) {
                    return "invalid.password.again".tr();
                  } else {
                    return null;
                  }
                }),
                Container(
                  margin: const EdgeInsets.only(top: 32.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'continue'.tr(),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    onPressed: () {
                      if (_keyValidationForm.currentState!.validate()) {
                        onForgotPassword();
                      }
                    },
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(25.0)),
                  ),
                ), //button: login
                RxLoginAccountLabel(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  //#endregion
  //#fuction main
  Future sendOTP(
      void Function(Object) fnError, void Function() fnSuccess) async {
    try {
      await AuthService.sendOTPPhone(phone, true, fnError, fnSuccess);
    } catch (error) {
      CommonMethods.showDialogError(context, error.toString());
    }
  }

  Future<bool> verifyOTP(String code) async {
    try {
      return await AuthService.verifyOTPPhone(phone, code);
    } catch (error) {
      CommonMethods.showDialogError(context, error.toString());
    }
    return false;
  }

  Future onForgotPassword() async {
    try {
      await AuthService.checkPhone(phone, isExist: true);
      var res = await showDialog(
          context: context,
          builder: (_) => ConfirmOtpPage(
                sendOTP: sendOTP,
                verifyOTP: verifyOTP,
              ));
      if (res!=null) {
        CommonMethods.showToast("Thay đổi password thành công");
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }
  //#end function main
}
