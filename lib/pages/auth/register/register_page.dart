// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                Get.isDarkMode ? Brightness.light : Brightness.dark,
            statusBarBrightness:
                Get.isDarkMode ? Brightness.dark : Brightness.light,
          ),
          iconTheme: IconThemeData(
            color: Get.isDarkMode
                ? AppColors.white
                : AppColors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: Get.isDarkMode ? Colors.black54 : AppColors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
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
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              LOGORAOXECOLORIMAGE,
              width: 180,
            ),
            const SizedBox(height: 30),
            Text("regist".tr.toUpperCase(),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            if (user!.phone != null) Text(user!.phone!, style: kTextHeaderStyle)
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                  key: _keyValidationForm,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                                          bottom: BorderSide(
                                              color: Colors.black26))),
                                  child: RxInput(user!.fullname!,
                                      labelText: "fullname".tr,
                                      icon: const FaIcon(
                                          FontAwesomeIcons.solidUser),
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
                                          bottom: BorderSide(
                                              color: Colors.black26))),
                                  child: RxInput(user!.phone!,
                                      keyboardType: TextInputType.number,
                                      labelText: "phone".tr,
                                      icon:
                                          const FaIcon(FontAwesomeIcons.phone),
                                      onChanged: (v) => {user!.phone = v},
                                      validator: (v) {
                                        if (v == null || !v.isNotEmpty) {
                                          return "notempty.phone".tr;
                                        } else {
                                          return CommonMethods.checkStringPhone(
                                                  v)
                                              ? null
                                              : "invalid.phone".tr;
                                        }
                                      })),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black26))),
                                  child: RxInput(
                                    user!.password!,
                                    isPassword: true,
                                    labelText: "password".tr,
                                    icon: const FaIcon(FontAwesomeIcons.lock),
                                    onChanged: (v) => {user!.password = v},
                                    validator: Validators.compose([
                                      Validators.required(
                                          "notempty.password".tr),
                                      Validators.patternString(
                                          RxParttern.password,
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
                                    icon: const FaIcon(FontAwesomeIcons.lock),
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
                          )))),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              RxLoginAccountLabel(context)
            ]));
  }

  Future<void> _onRegister() async {
    try {
      await AuthService.checkPhone(user!.phone, isExist: false);
      bool checkOtp = await CommonNavigates.openOtpVerificationPhoneDialog(
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
