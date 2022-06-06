// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/pages/forgot_password/forgot_password_page.dart';
import 'package:raoxe/pages/login/components/header_bar.dart';
import 'package:raoxe/pages/register/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> keyLogin = GlobalKey<FormState>();

  bool _hidePassword = true;
  late final TextEditingController ctrUserName = TextEditingController();
  late final TextEditingController ctrPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
        key: keyLogin,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const HeaderBar(),
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
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200))),
                          child: TextField(
                              controller: ctrUserName,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(top: 14.0),
                                prefixIcon: const Icon(
                                  Icons.phone,
                                ),
                                hintText: "enter.phone".tr(),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200))),
                          child: TextField(
                              controller: ctrPassword,
                              obscureText: _hidePassword,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(top: 14.0),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                  ),
                                  hintText: "enter.password.text".tr(),
                                  suffixIcon: IconButton(
                                    icon: Icon(_hidePassword == true
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _hidePassword = !_hidePassword;
                                      });
                                    },
                                  ))),
                        ),
                      ],
                    ),
                  ),
                  _forgotPasswordLabel(context),
                  Padding(
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
                              color: AppColors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  _createAccountLabel(context)
                ],
              ),
            ),
          )))
        ]));
  }
}

Widget _forgotPasswordLabel(context) {
  return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
            onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage()))
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterPage()));
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
