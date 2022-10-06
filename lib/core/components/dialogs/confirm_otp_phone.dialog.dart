// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:async';

import 'package:get/get.dart';
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

class OtpVerificationPhoneDialog extends StatefulWidget {
  final String phone;
  final bool isExist;

  const OtpVerificationPhoneDialog(
      {super.key, required this.phone, required this.isExist});
  @override
  State<OtpVerificationPhoneDialog> createState() => _OtpVerificationPhoneDialogState();
}

class _OtpVerificationPhoneDialogState extends State<OtpVerificationPhoneDialog> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String code = "";
  int expiredTime = 0;
  Future sendOTP(
      void Function(Object) fnError, void Function() fnSuccess) async {
    try {
      await AuthService.sendOTPPhone(
          widget.phone, widget.isExist, fnError, fnSuccess);
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
        if (mounted) {
          if (expiredTime == 0) {
            setState(() {
              timer.cancel();
            });
          } else {
            setState(() {
              expiredTime--;
            });
          }
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
        CommonMethods.showToast("success".tr);
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
      animationType: AnimationType.scale,
      pastedTextStyle: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color,
        fontWeight: FontWeight.bold,
      ),
      cursorColor: AppColors.primary,
      obscuringCharacter: '*',
      textStyle: TextStyle(
          fontSize: 20,
          height: 1.6,
          color: Theme.of(context).textTheme.bodyLarge!.color),
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(2),
          fieldHeight: 39,
          fieldWidth: 39,
          activeFillColor: Theme.of(context).cardColor,
          activeColor:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
          inactiveFillColor: Theme.of(context).cardColor,
          inactiveColor:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
          selectedColor: AppColors.primary,
          selectedFillColor: Theme.of(context).cardColor,
          borderWidth: 1),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: TextEditingController(),
      onCompleted: (v) {
        code = v;
      },
      appContext: context,
      onChanged: (value) {},
    );
    var form = Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text("message.str016".tr),
          Center(
              child: Text(
            widget.phone,
            style: const TextStyle().bold,
          )),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
              child: otpBox),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          Row(children: [
            Expanded(
              child: RxPrimaryButton(onTap: _submit, text: "continue".tr),
            )
          ]),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          InkWell(
              onTap: () => {if (expiredTime <= 0) sendotp()},
              child: expiredTime > 0
                  ? Text(
                      CommonMethods.convertTimeDuration(seconds: expiredTime),
                      style: const TextStyle(fontSize: 13.0),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "resend.code".tr,
                          style: kTextSubTitleStyle.italic.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.7)),
                        ),
                        Icon(AppIcons.sync_1,
                            size: 13,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.7)),
                      ],
                    )),
        ],
      ),
    );

    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('enter.verification.code'.tr),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding)
                    .copyWith(top: kDefaultPaddingTop / 2),
                child: form),
          ),
        ));
  }
}
