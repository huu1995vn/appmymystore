// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ConfirmOtpPage extends StatefulWidget {
  ConfirmOtpPage({super.key, required this.sendOTP, required this.verifyOTP});
  Future Function(
      void Function(Object) sentOTPFailed, void Function() codeSent)? sendOTP;
  Future<bool> Function(String text)? verifyOTP;

  @override
  ConfirmOtpPageState createState() => ConfirmOtpPageState();
}

class ConfirmOtpPageState extends State<ConfirmOtpPage> {
  String txtOtp = "";
  int expiredTime = 0;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    sendOTP();
  }

  sendOTP() async {
    CommonMethods.lockScreen();
    await widget.sendOTP!((error) {
      CommonMethods.showDialogError(context, error.toString());
      CommonMethods.unlockScreen();
    }, () {
      startTimer();
      CommonMethods.unlockScreen();
    });
  }

  verifyOTP() async {
    CommonMethods.lockScreen();
    try {
      var res = await widget.verifyOTP!(txtOtp);
      CommonNavigates.goBack(context, res);
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
    CommonMethods.unlockScreen();
  }

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: AppBar(
             iconTheme: const IconThemeData(
              color: AppColors.black //change your color here
            ),
            centerTitle: true,
            title: Text("Confirm your OTP", style: kTextHeaderStyle.copyWith(color: AppColors.black)),
            backgroundColor: AppColors.grey,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // const Spacer(),
                  Center(
                    child: Text(
                      'Please wait, we are confirming your OTP',
                      style: const TextStyle().italic,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      BGOTP,
                      height: SizeConfig.screenHeight * 0.25,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Center(
                      child: PinCodeTextField(
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(5),
                        activeFillColor: AppColors.white,
                        inactiveColor: AppColors.white,
                        selectedFillColor: AppColors.white,
                        inactiveFillColor: AppColors.white,
                        selectedColor: AppColors.primary,
                        activeColor: AppColors.success),
                    animationDuration: const Duration(milliseconds: 300),
                    cursorColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    controller: TextEditingController(),
                    // onCompleted: (v) {
                    //   print("Completed");
                    // },
                    appContext: context,
                    onChanged: (value) {
                      txtOtp = value;
                    },
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Resend again after ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14.0,
                        ),
                      ),
                      InkWell(
                        onTap: () => {if (!(expiredTime + 10 > 120)) sendOTP()},
                        child: Text(
                          expiredTime > 0
                              ? CommonMethods.convertTimeDuration(
                                      seconds: expiredTime) +
                                  "s"
                              : "expiredcode".tr(),
                          style: TextStyle(
                            fontWeight: (expiredTime + 10 > 120)
                                ? FontWeight.normal
                                : FontWeight.bold,
                            color: AppColors.info,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: kDefaultPaddingTop),
                    child: RxPrimaryButton(onTap: verifyOTP, text: "Verify"),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
