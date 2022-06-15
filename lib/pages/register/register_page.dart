// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
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
  UserModel user = UserModel();
  String passwordAgain = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
      // key: keyRegister,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: kDefaultPadding),
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(
                          LOGORAOXEWHITEIMAGE,
                          width: 150,
                        ),
                        Text("regist".tr(),
                            style: const TextStyle(color: AppColors.white))
                      ],
                    ),
                  ),
                ),
                getWidgetRegistrationCard(),
              ],
            )),
      ),
    );
  }

  Widget getWidgetRegistrationCard() {
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
                RxInput(user.username,
                    labelText: "fullname".tr(),
                    icon: const Icon(Icons.person),
                    onChanged: (v) => {
                          setState(() => {user.username = v})
                        },
                    validator: Validators.compose([
                            Validators.required("notempty.fullname.text".tr()),
                          ])
                          ),
                RxInput(user.phone,
                    keyboardType: TextInputType.number,
                    labelText: "phone".tr(),
                    icon: const Icon(Icons.phone),
                    onChanged: (v) => {
                          setState(() => {user.phone = v})
                        },
                     validator: Validators.compose([
                            Validators.required("notempty.phone.text".tr()),
                          ])
                    ),
                RxInput(user.password,
                    labelText: "password.text".tr(),
                    icon: const Icon(Icons.lock),
                    onChanged: (v) => {
                          setState(() => {user.password = v})
                        },
                    validator: Validators.compose([
                            Validators.required("notempty.password.text".tr()),
                            Validators.patternString(RxParttern.password,
                                "message.str017".tr())
                          ]),),
                RxInput(passwordAgain,
                    labelText: "password.again".tr(),
                    icon: const Icon(Icons.lock),
                    validator: (value) {
                            if (value != null && value != user.password) {
                              return "invalid"
                                  .tr(args: ["password.again".tr()]);
                            } else {
                              return null;
                            }
                          },),
                Container(
                  margin: const EdgeInsets.only(top: 32.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'continue'.tr(),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    onPressed: () {
                      if (_keyValidationForm.currentState!.validate()) {
                        _onTappedButtonRegister();
                      }
                    },
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(25.0)),
                  ),
                ), //button: login
                _loginLabel(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTappedButtonRegister() {}
}

Widget _loginLabel(context) {
  return InkWell(
    onTap: () {
      CommonNavigates.toLoginPage(context);
    },
    child: Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Already Register? ',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          Text(
            "login".tr(),
            style: const TextStyle(
                color: AppColors.primary500,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
