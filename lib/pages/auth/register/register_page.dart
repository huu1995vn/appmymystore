// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: user == null
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
            Text("regist".tr(), style: const TextStyle(color: AppColors.white)),
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
                RxInput(user!.fullname!,
                    labelText: "fullname".tr(),
                    icon: const Icon(AppIcons.user_1),
                    onChanged: (v) => {
                          user!.fullname = v
                        },
                    validator: Validators.compose([
                      Validators.required("notempty.fullname.text".tr()),
                    ])),
                RxInput(user!.phone!,
                    keyboardType: TextInputType.number,
                    labelText: "phone".tr(),
                    icon: const Icon(AppIcons.phone_handset),
                    onChanged: (v) => {
                          user!.phone = v
                        },
                    validator: (v) {
                      if (v == null || !v.isNotEmpty) {
                        return "notempty.phone.text".tr();
                      } else {
                        return CommonMethods.checkStringPhone(v)
                            ? null
                            : "invalid.phone".tr();
                      }
                    }),
                RxInput(
                  user!.password!,
                  isPassword: true,
                  labelText: "password.text".tr(),
                  icon: const Icon(AppIcons.lock_1),
                  onChanged: (v) => {
                     user!.password = v
                  },
                  validator: Validators.compose([
                    Validators.required("notempty.password.text".tr()),
                    Validators.patternString(
                        RxParttern.password, "message.str017".tr())
                  ]),
                ),
                RxInput(
                  passwordAgain,
                  isPassword: true,
                  labelText: "password.again".tr(),
                  icon: const Icon(AppIcons.lock_1),
                  validator: (value) {
                    if (value != null && value != user!.password) {
                      return "invalid.password.again".tr();
                    } else {
                      return null;
                    }
                  },
                ),
                RxPrimaryButton(
                    onTap: () {
                      if (_keyValidationForm.currentState!.validate()) {
                        _onRegister();
                      }
                    },
                    text: 'continue'.tr()),
                //button: login
                RxLoginAccountLabel(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRegister() async {
    try {      
      await AuthService.checkPhone(user!.phone, isExist: false);
      bool res = await CommonNavigates.openOtpVerificationDialog(context, user!.phone!, false);
      //api đăng ký
      CommonMethods.showToast("Đăng ký thành công");
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }
}
