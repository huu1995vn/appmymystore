// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, prefer_is_empty, non_constant_identifier_names, must_be_immutable

import 'package:flutter/services.dart';
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
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
// ignore: unused_import
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ChangeEmailDiaLog extends StatefulWidget {
  ChangeEmailDiaLog({super.key, required this.data});
  UserModel data;
  @override
  State<ChangeEmailDiaLog> createState() => _ChangeEmailDialogState();
}

class _ChangeEmailDialogState extends State<ChangeEmailDiaLog> {
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  String email = "";
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
        title: Text('change.email'.tr),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Column(
              children: <Widget>[
                _body(),
              ],
            )),
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
                      child: RxInput(email,
                          labelText: "new.email".tr,
                          icon: const Icon(AppIcons.lock_1),
                          onChanged: (v) => {
                                setState(() => {email = v})
                              },
                          validator: Validators.compose([
                            Validators.required("notempty.email".tr),
                            Validators.patternString(
                                RxParttern.email, "invalid.email".tr)
                          ])),
                    ),
                  ],
                )),
          ),
          Row(children: [
            Expanded(
              child: RxPrimaryButton(
                  onTap: () {
                    if (_keyValidationForm.currentState!.validate()) {
                      onChangeEmail();
                    }
                  },
                  text: 'continue'.tr),
            )
          ]),
        ]),
      ),
    );
  }

  //#endregion
  //#fuction main
  Future onChangeEmail() async {
    try {
      await AuthService.checkEmail(email, isExist: false);
      
      bool checkOtp = true; //
      // await CommonNavigates.openOtpVerificationDialog(
      //     context, widget.data.phone!, true);
      if (checkOtp != null && checkOtp) {
        var res = await DaiLyXeApiBLL_APIUser()
            .updateemail(email);
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
