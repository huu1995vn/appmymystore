// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/pages/auth/login/widgets/login_header.widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> keyLogin = GlobalKey<FormState>();
  String username = "";
  String password = "";
  login(String username, String password){
    AuthService.login(context, username, password);
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
        key: keyLogin,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const LoginHeaderWidget(),
          Expanded(
              child: RxWrapper(
                  body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: AppColors.gray))),
                              child: RxInput(
                                username,
                                labelText: "phone".tr(),
                                icon: const Icon(Icons.phone),
                                keyboardType: TextInputType.number,
                                onChanged: (v) => {username = v},
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: AppColors.gray))),
                                child: RxInput(
                                  password,
                                  isPassword: true,
                                  labelText: "password.text".tr(),
                                  icon: const Icon(Icons.lock),
                                  onChanged: (v) => {password = v},
                                )),
                          ],
                        ),
                      )),
                  _forgotPasswordLabel(context),
                  _buttonLogin(context, onTap: () {
                    login(username, password);
                  }),
                  _createAccountLabel(context)
                ],
              ),
            ),
          )))
        ]));
  }
}

Widget _buttonLogin(context, {Function()? onTap}) {
  return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: kBoxDecorationStyle.copyWith(
              borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text(
              "continue".tr().toUpperCase(),
              style: const TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ));
}

Widget _forgotPasswordLabel(context) {
  return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
            onTap: () {
              CommonNavigates.toForgotPasswordPage(context);
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'forgot.password'.tr(),
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )),
      ));
}

Widget _createAccountLabel(context) {
  return InkWell(
    onTap: () {
      CommonNavigates.toRegisterPage(context);
    },
    child: Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "message.str036".tr(),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          // const SizedBox(
          //   width: 10,
          // ),
          Text(
            "registnow".tr(),
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
