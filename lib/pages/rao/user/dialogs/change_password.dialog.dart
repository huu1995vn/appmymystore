// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, prefer_is_empty, non_constant_identifier_names, must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_input.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
// ignore: unused_import
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ChangePasswordDiaLog extends StatefulWidget {
  ChangePasswordDiaLog({super.key, required this.data});
  UserModel data;
  @override
  State<ChangePasswordDiaLog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDiaLog> {
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
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
        centerTitle: true,
        title: Text('change.password'.tr),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child:  Column(
              children: <Widget>[
                _body(),
              ],
            ),
      ),
    );
  }

  Widget _body() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: <Widget>[
        Form(
          key: _keyValidationForm,
          child: Column(
            children: <Widget>[
              RxInput(password,
                  isPassword: true,
                  isBorder: true,
                  labelText: "password.new".tr,
                  onChanged: (v) => {
                        setState(() => {password = v})
                      },
                  validator: Validators.compose([
                    Validators.required("notempty.password".tr),
                  ])),
              SizedBox(height: 20),
              RxInput(passwordAgain,
                  isPassword: true,
                  isBorder: true,
                  labelText: "password.again".tr, validator: (value) {
                if (value != null && value != password) {
                  return "invalid.password.again".tr;
                } else {
                  return null;
                }
              }),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "message.str004".tr,
          style: kTextSubTitleStyle.italic,
        ),
        SizedBox(
          height: 40,
        ),
        Row(children: [
          Expanded(
            child: RxPrimaryButton(
                onTap: () {
                  if (_keyValidationForm.currentState!.validate()) {
                    onChangePassword();
                  }
                },
                text: 'continue'.tr),
          )
        ]),
      ]),
    ));
  }

  //#endregion
  //#fuction main
  Future onChangePassword() async {
    try {
      await AuthService.checkPhone(widget.data.phone, isExist: true);
      bool checkOtp = await CommonNavigates.openOtpVerificationPhoneDialog(
          context, widget.data.phone!, true);
      if (checkOtp != null && checkOtp) {
        var res = await DaiLyXeApiBLL_APIAnonymous()
            .forgotpassword(widget.data.phone!, password);
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
