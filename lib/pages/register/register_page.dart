// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/pages/login/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  final TextEditingController _textEditConName = TextEditingController();
  final TextEditingController _textEditConEmail = TextEditingController();
  final TextEditingController _textEditConPassword = TextEditingController();
  final TextEditingController _textEditConConfirmPassword = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
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
                getWidgetImageLogo(),
                getWidgetRegistrationCard(),
              ],
            )),
      ),
    );
  }

  Widget getWidgetImageLogo() {
    return Center(
      child: Column(
        children: [
          Image.asset(
            LOGORAOXEWHITEIMAGE,
            width: 150,
          ),
          const Text(
            'Register',
            style: TextStyle(
              color: AppColors.white,
              // fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
                TextFormField(
                  controller: _textEditConName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  // validator: _validateUserName,
                  // onFieldSubmitted: (String value) {
                  //   FocusScope.of(context).requestFocus(_passwordEmail);
                  // },
                  decoration: const InputDecoration(
                      labelText: 'Full name',
                      //prefixIcon: Icon(Icons.email),
                      icon: Icon(Icons.perm_identity)),
                ), //text field : user name
                TextFormField(
                  controller: _textEditConEmail,
                  // focusNode: _passwordEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                  decoration: const InputDecoration(
                      labelText: 'Phone', icon: Icon(Icons.phone)),
                ),
                TextFormField(
                  controller: _textEditConPassword,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  // validator: _validatePassword,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      icon: const Icon(Icons.lock)),
                ), //text field: password
                TextFormField(
                    controller: _textEditConConfirmPassword,
                    // focusNode: _passwordConfirmFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    // validator: _validateConfirmPassword,
                    obscureText: !isConfirmPasswordVisible,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: Icon(isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                            });
                          },
                        ),
                        icon: const Icon(Icons.lock))),
                Container(
                  margin: const EdgeInsets.only(top: 32.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 16.0),
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

  String? _validateUserName(String value) {
    return value.trim().isEmpty ? "Name can't be empty" : null;
  }

  String? _validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value == null || !regex.hasMatch(value)) {
      return 'Invalid Email';
    } else {
      return null;
    }
  }

  String? _validatePassword(String value) {
    return value.length < 5 ? 'Min 5 char required' : null;
  }

  String? _validateConfirmPassword(String value) {
    return value.length < 5 ? 'Min 5 char required' : null;
  }

  void _onTappedButtonRegister() {}
}

Widget _loginLabel(context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
