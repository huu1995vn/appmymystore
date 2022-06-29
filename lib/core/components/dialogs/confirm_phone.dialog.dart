// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/auth/confirm_otp_page.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ConfirmPhoneDialog extends StatefulWidget {
  const ConfirmPhoneDialog({
    super.key,
    this.phone,
    required this.isExist,
  });
  final String? phone;
  final bool isExist;
  @override
  State<ConfirmPhoneDialog> createState() => _ConfirmPhoneDialogState();
}

class _ConfirmPhoneDialogState extends State<ConfirmPhoneDialog> {
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  String phone = "";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    if (widget.phone!=null &&
        CommonMethods.checkStringPhone(widget.phone!)) {
      setState(() {
        phone = widget.phone!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: phone == null
          ? Expanded(
              child: Center(
              child: Text("notfound".tr()),
            ))
          : SingleChildScrollView(
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
            Text("OTP", style: kTextHeaderStyle.copyWith(color: AppColors.white)),
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
                    labelText: "phone".tr(),
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    icon: const Icon(AppIcons.phone_handset),
                    onChanged: (v) => {
                          phone = v
                        },
                    validator: Validators.compose([
                      Validators.required("notempty.phone.text".tr()),
                    ])),
                RxPrimaryButton(
                    onTap: () {
                      if (_keyValidationForm.currentState!.validate()) {
                        _onDone();
                      }
                    },
                    text: 'continue'.tr()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future sendOTP(
      void Function(Object) fnError, void Function() fnSuccess) async {
    try {
      await AuthService.sendOTPPhone(phone, false, fnError, fnSuccess);
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

  Future<void> _onDone() async {
    try {
      await AuthService.checkPhone(phone, isExist: widget.isExist);
      var res = await showDialog(
          context: context,
          builder: (_) => ConfirmOtpPage(
                sendOTP: sendOTP,
                verifyOTP: verifyOTP,
              ));
      if (res != null) {
        CommonNavigates.goBack(context, phone);
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }
}
