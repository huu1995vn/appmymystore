// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
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
                style: const TextStyle(color: AppColors.white)),
            if (phone != null)
              Text(phone,
                  style: kTextHeaderStyle.copyWith(color: AppColors.white))
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
                RxPrimaryButton(
                    onTap: () {
                      if (_keyValidationForm.currentState!.validate()) {
                        onForgotPassword();
                      }
                    },
                    text: 'continue'.tr()),
                //button: login
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
  Future onForgotPassword() async {
    try {
      await AuthService.checkPhone(phone, isExist: true);
      bool res =
          await CommonNavigates.openOtpVerificationDialog(context, phone, true);
      if (res != null) {
        CommonMethods.showToast("Thay đổi password thành công");
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }
  //#end function main
}
