// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/components/index.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/services/auth.service.dart';
import 'package:mymystore/core/utilities/extensions.dart';

class PhoneAuthDialog extends StatefulWidget {
  const PhoneAuthDialog(
      {Key? key, this.isExist = false, this.title = "", this.phone = ""})
      : super(key: key);
  final bool isExist;
  final String title;
  final String phone;

  @override
  PhoneAuthDialogState createState() => PhoneAuthDialogState();
}

class PhoneAuthDialogState extends State<PhoneAuthDialog> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = "";
  TextEditingController otpEditingController = TextEditingController();
  String? _verificationId;
  int? forceResendingToken;
  bool showOtpScreen = false;
  late StreamController<ErrorAnimationType> errorController;
  Timer? _timer;
  int expiredTime = 0;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    firebaseAuth.setLanguageCode(CommonConfig.LanguageCode);
    setState(() {
      showOtpScreen = widget.phone.isNotNullEmpty;
      phoneNumber = widget.phone;
      if (showOtpScreen) onSendOTP();
    });
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  void startTimer() {
    if (_timer != null) _timer!.cancel();
    expiredTime = CommonConfig.TimeVerify * 60;
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

  void onSendOTP() async {
    if (phoneNumber.isNotNullEmpty || _formKey.currentState!.validate()) {
      try {
        await AuthService.checkPhone(phoneNumber, isExist: widget.isExist);
        CommonMethods.lockScreen();
        verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
          // widget.onSuccess(phoneNumber);
          //Không cần làm gì cả
        }
        verificationFailed(FirebaseAuthException ex) {
          CommonMethods.unlockScreen();
          CommonMethods.showToast(getMessageFromErrorCode(ex.code));
        }

        codeSent(String? verificationId, [int? forceResendingToken]) async {
          CommonMethods.unlockScreen();
          CommonMethods.showToast("message.str018".tr);
          this.forceResendingToken = forceResendingToken;
          _verificationId = verificationId;
          startTimer();
        }

        codeAutoRetrievalTimeout(String verificationId) {
          _verificationId = verificationId;
        }

        await firebaseAuth.verifyPhoneNumber(
            phoneNumber:
                CommonMethods.convertNumberPhoneWithCountryCode(phoneNumber),
            timeout: Duration(seconds: CommonConfig.TimeVerify * 60),
            forceResendingToken: forceResendingToken,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
        showOtpScreen = true;
      } catch (e) {
        CommonMethods.showToast("$e");
        showOtpScreen = false;
      }
    }
  }

  bool get checkVerifyOTP {
    return otpEditingController.text != null &&
        otpEditingController.text.length == 6 &&
        expiredTime > 0;
  }

  void onVerifyOTP() async {
    bool error = false;
    User? user;
    AuthCredential credential;
    if (!checkVerifyOTP) {
      CommonMethods.showToast("invalid.data".tr);
      return;
    }
    CommonMethods.lockScreen();
    try {
      credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otpEditingController.text,
      );
      user = (await firebaseAuth.signInWithCredential(credential)).user!;
    } catch (e) {
      FirebaseAuthException ex = e as FirebaseAuthException;
      CommonMethods.showToast(getMessageFromErrorCode(ex.code));
      error = true;
    }
    if (!error && user != null && user.uid != null) {
      CommonNavigates.goBack(context, phoneNumber);
    }
    CommonMethods.unlockScreen();
  }

  Widget SendOTPScreen() {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            Column(children: <Widget>[
              MMText(data:
                "message.str019".tr,
                style: CommonConstants.kTextSubTitleStyle,
              ),
              const SizedBox(height: 15),
            ]),
            MMInput(phoneNumber,
                keyboardType: TextInputType.number,
                labelText: "phone".tr,
                icon: const Icon(AppIcons.phone_1),
                onChanged: (v) => {
                      setState(() => {phoneNumber = v})
                    },
                validator: (v) {
                  if (v == null || !v.isNotEmpty) {
                    return "notempty.phone".tr;
                  } else {
                    return CommonMethods.checkStringPhone(v)
                        ? null
                        : "invalid.phone".tr;
                  }
                }),
            const SizedBox(height: CommonConstants.kDefaultMargin),
            Row(children: [
              Expanded(
                child: MMPrimaryButton(
                    onTap: () {
                      onSendOTP();
                    },
                    text: 'continue'.tr),
              )
            ]),
          ],
        ));
  }

  Widget VerifyOTPScreen() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
          child: Column(
            children: <Widget>[
              MMText(data:"message.str016".tr),
              const SizedBox(
                height: CommonConstants.kDefaultMargin,
              ),
              Center(
                  child: MMText(data:
                CommonMethods.convertNumberPhoneWithCountryCode(phoneNumber),
                style: const TextStyle(fontSize: 25).bold,
              )),
              const SizedBox(
                height: CommonConstants.kDefaultMargin,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    hintCharacter: '0',
                    hintStyle: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.5),
                    ),
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      borderWidth: 0,
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeColor:
                          Theme.of(context).textTheme.bodyLarge!.color!,
                      activeFillColor: Theme.of(context).cardColor,
                      inactiveFillColor: Theme.of(context).cardColor,
                      selectedFillColor: Theme.of(context).cardColor,
                      inactiveColor: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.5),
                      selectedColor: Colors.transparent,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: otpEditingController,
                    onCompleted: (v) {
                      onVerifyOTP();
                    },
                    onChanged: (value) {
                      CommonMethods.wirtePrint(value);
                    },
                    beforeTextPaste: (text) {
                      CommonMethods.wirtePrint("Allowing to paste $text");
                      return true;
                    },
                  )),
              const SizedBox(
                height: CommonConstants.kDefaultMargin,
              ),
              Row(children: [
                Expanded(
                  child: MMDisabled(
                      disabled: !checkVerifyOTP,
                      child: MMPrimaryButton(
                          onTap: onVerifyOTP, text: "continue".tr)),
                )
              ]),
              const SizedBox(
                height: CommonConstants.kDefaultMargin,
              ),
              InkWell(
                  onTap: () => {if (expiredTime <= 0) onSendOTP()},
                  child: expiredTime > 0
                      ? MMText(data:
                          "${CommonMethods.convertTimeDuration(seconds: expiredTime)}s",
                          style: CommonConstants.kTextSubTitleStyle.italic,
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MMText(data:
                              "resend.code".tr,
                              style: CommonConstants.kTextSubTitleStyle.italic,
                            ),
                            const SizedBox(width: CommonConstants.kDefaultMargin),
                            Icon(AppIcons.sync_1,
                                size: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(0.7)),
                          ],
                        )),
            ],
          ),
        ));
  }

  String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return CommonConfig.LanguageCode == "en"
            ? "Email already used. Go to login page."
            : "Email đã được sử dụng. Tới trang đăng nhập.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return CommonConfig.LanguageCode == "en"
            ? "Wrong email/password combination."
            : "Email/mật khẩu sai.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return CommonConfig.LanguageCode == "en"
            ? "No user found with this email."
            : "Không tìm thấy người dùng nào với email này.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return CommonConfig.LanguageCode == "en"
            ? "User disabled."
            : "Người dùng bị vô hiệu hóa.";
      case "ERROR_TOO_MANY_REQUESTS":
      case "too-many-requests":
      case "operation-not-allowed":
        return CommonConfig.LanguageCode == "en"
            ? "Too many attempts please try later"
            : "Quá nhiều lần thử, vui lòng thử lại sau";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return CommonConfig.LanguageCode == "en"
            ? "Email address is invalid."
            : "Địa chỉ email không hợp lệ.";
      case "network-request-failed":
        return CommonConfig.LanguageCode == "en"
            ? "No Internet Connection"
            : "Không có kết nối Internet";
      case "invalid-verification-code":
        return CommonConfig.LanguageCode == "en"
            ? "Invalid verification code"
            : "Mã xác minh không hợp lệ";

      default:
        return CommonConfig.LanguageCode == "en"
            ? "Please try again."
            : "Vui lòng thử lại";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context)
              .textTheme
              .bodyLarge!
              .color, //change your color here
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:  const EdgeInsets.all(CommonConstants.kDefaultPadding),
            child: Column(children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      CommonConstants.IMAGE_LOGO,
                      width: 180,
                    ),
                    const SizedBox(height: 30),
                    MMText(data:
                      widget.title.tr.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              showOtpScreen ? VerifyOTPScreen() : SendOTPScreen(),
            ])),
      ),
    );
  }
}
