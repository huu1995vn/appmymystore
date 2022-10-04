// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:get/get.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  UserModel? user;
  String passwordAgain = "";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    setState(() {
      user = UserModel();
      user!.phone = "";
      user!.fullname = "";
      user!.password = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                Brightness.dark, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness:
                Brightness.light, //<-- For iOS SEE HERE (dark icons)
          ),
          iconTheme: const IconThemeData(
            color: AppColors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _header(),
              _body(),
            ],
          ),
        )));
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              LOGORAOXECOLORIMAGE,
              width: 150,
            ),
            Text("regist".tr, style: const TextStyle(color: AppColors.white)),
            if (user!.phone != null)
              Text(user!.phone!,
                  style: kTextHeaderStyle.copyWith(color: AppColors.white))
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                  key: _keyValidationForm,
                  child: Container(
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
                                      bottom:
                                          BorderSide(color: Colors.black26))),
                              child: RxInput(user!.fullname!,
                                  labelText: "fullname".tr,
                                  icon: const Icon(AppIcons.user_1),
                                  onChanged: (v) => {user!.fullname = v},
                                  validator: Validators.compose([
                                    Validators.required(
                                        "notempty.fullname".tr),
                                  ]))),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.black26))),
                              child: RxInput(user!.phone!,
                                  keyboardType: TextInputType.number,
                                  labelText: "phone".tr,
                                  icon: const Icon(AppIcons.phone_handset),
                                  onChanged: (v) => {user!.phone = v},
                                  validator: (v) {
                                    if (v == null || !v.isNotEmpty) {
                                      return "notempty.phone".tr;
                                    } else {
                                      return CommonMethods.checkStringPhone(v)
                                          ? null
                                          : "invalid.phone".tr;
                                    }
                                  })),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.black26))),
                              child: RxInput(
                                user!.password!,
                                isPassword: true,
                                labelText: "password".tr,
                                icon: const Icon(AppIcons.lock_1),
                                onChanged: (v) => {user!.password = v},
                                validator: Validators.compose([
                                  Validators.required(
                                      "notempty.password".tr),
                                  Validators.patternString(RxParttern.password,
                                      "message.str004".tr)
                                ]),
                              )),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: RxInput(
                                passwordAgain,
                                isPassword: true,
                                labelText: "password.again".tr,
                                icon: const Icon(AppIcons.lock_1),
                                validator: (value) {
                                  if (value != null &&
                                      value != user!.password) {
                                    return "invalid.password.again".tr;
                                  } else {
                                    return null;
                                  }
                                },
                              )),
                        ],
                      ))),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: RxPrimaryButton(
                        onTap: () {
                          if (_keyValidationForm.currentState!.validate()) {
                            _onRegister();
                          }
                        },
                        text: 'continue'.tr.toUpperCase()),
                  )
                ],
              ),
              SizedBox(height: 20),
              RxLoginAccountLabel(context)
            ]));
  }

  Future<void> _onRegister() async {
    try {
      await AuthService.checkPhone(user!.phone, isExist: false);
      bool checkOtp = await CommonNavigates.openOtpVerificationDialog(
          context, user!.phone!, false);
      if (checkOtp) {
        var res =
            await DaiLyXeApiBLL_APIAnonymous().insertuser(user!.toInsert());
        if (res.status > 0) {
          CommonMethods.showDialogCongratulations(context, "message.str008".tr);
        } else {
          CommonMethods.showToast(res.message);
        }
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }
}
