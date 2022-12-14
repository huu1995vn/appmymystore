// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/index.dart';
import 'package:mymystore/core/services/auth.service.dart';
import 'package:mymystore/core/utilities/extensions.dart';

class PasswordAuthDialog extends StatefulWidget {
  const PasswordAuthDialog({Key? key, required this.username})
      : super(key: key);
  final String username;

  @override
  PasswordAuthDialogState createState() => PasswordAuthDialogState();
}

class PasswordAuthDialogState extends State<PasswordAuthDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpEditingController = TextEditingController();
  int? forceResendingToken;
  bool showOtpScreen = false;
  String phoneNumber = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      phoneNumber = CommonMethods.formatPhoneNumber(widget.username);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onVerifyPassword() async {
    if (phoneNumber.isNotNullEmpty || _formKey.currentState!.validate()) {
      await AuthService.checkPhone(phoneNumber, isExist: true);
      var res = await AuthService.login(context, phoneNumber, password);
      if (res) {
        CommonNavigates.goBack(context, phoneNumber);
      } else {
        CommonMethods.showToast("invalid.password".tr);
      }
    }
  }

  Widget VerifyScreen() {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            MMInput(
              password,
              isPassword: true,
              labelText: "password".tr,
              icon: const Icon(AppIcons.lock_1),
              onChanged: (v) => {password = v},
            ),
            const SizedBox(height: CommonConstants.kDefaultMargin),
            Row(children: [
              Expanded(
                child: MMPrimaryButton(
                    onTap: () {
                      onVerifyPassword();
                    },
                    text: 'continue'.tr),
              )
            ]),
          ],
        ));
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
            padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
            child: Column(children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      CommonConstants.IMAGE_LOGO,
                      width: 180,
                    ),
                    const SizedBox(height: 30),
                    MMText(
                      data: "enter.password".tr.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              VerifyScreen(),
            ])),
      ),
    );
  }
}
