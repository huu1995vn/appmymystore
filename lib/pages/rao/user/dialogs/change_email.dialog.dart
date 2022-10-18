// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, prefer_is_empty, non_constant_identifier_names, must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_input.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/utilities/constants.dart';
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
        child: Card( 
          margin: EdgeInsets.only(top: kDefaultMarginBottomBox),
            child: Column(
              children: <Widget>[
                _body(),
              ],
            )),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: <Widget>[
        Form(
          key: _keyValidationForm,
          child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  Container( 
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),   
                    child: RxInput(email,
                        labelText: "new.email".tr,
                        isBorder: true,
                        onChanged: (v) => {
                              setState(() => {email = v})
                            },
                        validator: Validators.compose([
                          Validators.required("notempty".tr),
                          Validators.patternString(
                              RxParttern.email, "invalid.email".tr)
                        ])
                       
                        ),
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
    );
  }

  //#endregion
  //#fuction main
  Future onChangeEmail() async {
    try {
      if (email!=null && widget.data.email==email) {
        throw "message.alert02".tr;
      }
      AuthService.checkEmail(email);
      bool checkOtp =
          await CommonNavigates.openOtpVerificationEmailDialog(context, email);
      if (checkOtp != null && checkOtp) {
        CommonMethods.showToast("success".tr);
        CommonNavigates.goBack(context, email);
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }
  //#end function main
}
