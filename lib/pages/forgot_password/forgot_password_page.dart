import 'package:flutter/material.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool _hidePassword = true;
  late final TextEditingController ctrUserName = TextEditingController();
  late final TextEditingController ctrPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return RxScaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Image.asset(
                  LOGORAOXEWHITEIMAGE,
                  width: 150,
                ),
                const Text(
                  'Welcome to back',
                  style: TextStyle(
                    color: AppColors.white,
                    // fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 29,
          ),
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
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () => print('Sign Up Button Pressed'),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'forgot.password.text'.tr(),
                                    style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      )),
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
                ],
              ),
            ),
          )))
        ]));
  }
}
