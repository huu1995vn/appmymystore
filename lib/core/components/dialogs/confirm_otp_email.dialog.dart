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

class OtpVerificationEmailDialog extends StatefulWidget {
  final String email;

  const OtpVerificationEmailDialog({super.key, required this.email});
  @override
  State<OtpVerificationEmailDialog> createState() =>
      _OtpVerificationEmailDialogState();
}

class _OtpVerificationEmailDialogState
    extends State<OtpVerificationEmailDialog> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String code = "";
  int expiredTime = 0;
  Future sendOTP(
      void Function(Object) fnError, void Function() fnSuccess) async {
    try {
      await AuthService.sendOTPEmail(widget.email, fnError, fnSuccess);
    } catch (error) {
      CommonMethods.showDialogError(context, error.toString());
    }
  }

  Future<bool> verifyOTP() async {
    try {
      return await AuthService.verifyOTPEmail(code);
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
      sendOTP((e) async {
        if (_timer != null) _timer!.cancel();
         CommonMethods.unlockScreen();
        await CommonMethods.showDialogError(context, e.toString());
        CommonNavigates.goBack(context);
      }, 
      () {
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
      animationType: AnimationType.scale,
      pastedTextStyle: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color,
        fontWeight: FontWeight.bold,
      ),
      cursorColor: AppColors.primary,
      textStyle: TextStyle(
          fontSize: 18,
          height: 1.4,
          color: Theme.of(context).textTheme.bodyLarge!.color),
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(4),
          fieldHeight: 45,
          fieldWidth: 40,
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
        _submit();
      },
      appContext: context,
      onChanged: (value) {},
    );
    var form = Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text("message.str016".tr),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                widget.email,
                style: const TextStyle(fontSize: 25).bold,
              )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: otpBox),
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
              InkWell(
                  onTap: () => {if (expiredTime <= 0) sendotp()},
                  child: expiredTime > 0
                      ? Text(
                          CommonMethods.convertTimeDuration(
                              seconds: expiredTime),
                          style: const TextStyle(fontSize: 16),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "resend.code".tr,
                              style: kTextSubTitleStyle.italic.copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.7)),
                            ),
                            const SizedBox(width: 5),
                            Icon(AppIcons.sync_1,
                                size: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(0.7)),
                          ],
                        )),
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                Expanded(
                  child: RxPrimaryButton(onTap: _submit, text: "continue".tr),
                )
              ]),
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
