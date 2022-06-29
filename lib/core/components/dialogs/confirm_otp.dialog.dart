// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class OtpVerificationDialog extends StatefulWidget {
  final String phone;
  final bool isExist;

  const OtpVerificationDialog({super.key, required this.phone, required this.isExist});
  @override
  State<OtpVerificationDialog> createState() => _OtpVerificationDialogState();
}

class _OtpVerificationDialogState extends State<OtpVerificationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String code = "";
  int expiredTime = 0;
  Future sendOTP(
      void Function(Object) fnError, void Function() fnSuccess) async {
    try {
      await AuthService.sendOTPPhone(widget.phone, widget.isExist, fnError, fnSuccess);
    } catch (error) {
      CommonMethods.showDialogError(context, error.toString());
    }
  }

  Future<bool> verifyOTP() async {
    try {
      return await AuthService.verifyOTPPhone(widget.phone, code);
    } catch (error) {
      CommonMethods.showDialogError(context, error.toString());
    }
    return false;
  }

  Timer? _timer;
  void startTimer() {
    if (_timer != null) _timer!.cancel();
    expiredTime = 120;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (expiredTime == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            expiredTime--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    sendotp();
  }

  void sendotp() {
    CommonMethods.lockScreen();
    try {
      sendOTP((e) {
        CommonMethods.showDialogError(context, e.toString());
        CommonMethods.unlockScreen();
      }, () {
        startTimer();
        CommonMethods.unlockScreen();
      });
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());

      CommonMethods.unlockScreen();
    }
  }

  Future<void> _submit() async {
    if (code != null && code.length == 6) {
      bool res = await verifyOTP();
      if (res) {
        CommonNavigates.goBack(context, res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var otpBox = PinCodeTextField(
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      length: 6,
      obscureText: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          activeFillColor: AppColors.grayDark,
          inactiveColor: AppColors.grayDark,
          selectedFillColor: AppColors.grayDark,
          inactiveFillColor: AppColors.grayDark,
          selectedColor: AppColors.grayDark,
          activeColor: AppColors.grayDark),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: TextEditingController(),
      onCompleted: (v) {
        code = v;
      },
      appContext: context,
      onChanged: (value) {},
    );
    var form = Column(
      children: <Widget>[
        Container(
          alignment: FractionalOffset.center,
          margin: const EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 0.0),
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Color(0xFFF9F9F9),
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  "Enter valid recieved OTP",
                  style: kTextHeaderStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: InkWell(
                      onTap: () => {if (expiredTime <= 0) sendotp()},
                      child: expiredTime > 0
                          ? Text(
                              CommonMethods.convertTimeDuration(
                                  seconds: expiredTime),
                              style: const TextStyle(fontSize: 13.0),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "sendcode".tr(),
                                  style: const TextStyle(color: AppColors.info)
                                      .size(13),
                                ),
                                const Icon(AppIcons.sync_1,
                                    size: 13, color: AppColors.info),
                              ],
                            )),
                ),
                otpBox,
                const SizedBox(
                  width: 0.0,
                  height: 20.0,
                ),
                RxPrimaryButton(onTap: _submit, text: "Verify OTP")
              ],
            ),
          ),
        ),
      ],
    );
    var screenRoot = Container(
      height: double.maxFinite,
      alignment: FractionalOffset.center,
      child: SingleChildScrollView(
        child: Center(
          child: form,
        ),
      ),
    );
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF2B2B2B),
          appBar: null,
          key: _scaffoldKey,
          body: screenRoot,
        ));
  }
}
