// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/index.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/services/auth.service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/utilities/extensions.dart';
// ignore: unused_import
import 'package:wc_form_validators/wc_form_validators.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String phone;
  const ForgotPasswordPage({super.key, required this.phone});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
   final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  String phone = "";
  String password = "";
  String passwordAgain = "";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    if (widget.phone.isNotNullEmpty) {
      setState(() {
        phone = widget.phone;
      });
    } else {
      CommonMethods.showToast("invalid.data".tr);
      CommonNavigates.goBack(context);
    }
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
      // backgroundColor: Get.isDarkMode ? Colors.black54 : AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
            child: Column(
              children: <Widget>[
                _header(),
                _body(),
              ],
            )),
      ),
    );
  }

  //#region widgets private
  Widget _header() {
    return Center(
      child: Column(
        children: [
          Image.asset(
            CommonConstants.IMAGE_LOGO,
            width: 180,
          ),
          const SizedBox(height: 30),
          MMText(data:
            "forgot.password".tr.toUpperCase(),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Column(children: <Widget>[
      Center(
          child: MMText(data:
        CommonMethods.convertNumberPhoneWithCountryCode(phone),
        style: const TextStyle(fontSize: 19).bold,
      )),
      const SizedBox(height: 15),
      Form(
          key: _keyValidationForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MMInput(password,
                  isPassword: true,
                  labelText: "password.new".tr,
                  icon: const Icon(AppIcons.lock_1),
                  onChanged: (v) => {
                        setState(() => {password = v})
                      },
                  validator: Validators.compose([
                    Validators.required("notempty.password".tr),
                  ])),
              MMText(data:"message.str004".tr,
                  style: CommonConstants.kTextSubTitleStyle
                      .size(10)
                      .italic
                      .copyWith(color: AppColors.error)),
              MMInput(passwordAgain,
                  isPassword: true,
                  labelText: "password.again".tr,
                  icon: const Icon(AppIcons.lock_1),
                  validator: (value) {
                if (value != null && value != password) {
                  return "invalid.password.again".tr;
                } else {
                  return null;
                }
              }),
            ],
          )),
      const SizedBox(height: CommonConstants.kDefaultMargin),
      Row(children: [
        Expanded(
          child: MMPrimaryButton(
              onTap: () {
                if (_keyValidationForm.currentState!.validate()) {
                  onForgotPassword();
                }
              },
              text: 'continue'.tr),
        )
      ]),
      const SizedBox(
        height: 20,
      ),
      //button: login
      MMLoginAccountLabel(context)
    ]);
  }

  //#endregion
  //#fuction main
  Future onForgotPassword() async {
    try {
      await AuthService.checkPhone(phone, isExist: true);
      // var res =
      //     await DaiLyXeApiBLL_APIUser().forgotpassword(phone, password);
      // if (res.status > 0) {
      //   CommonNavigates.toLoginPage(context);
      //   CommonMethods.showToast("success".tr);
      // } else {
      //   CommonMethods.showToast(res.message);
      // }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }
  //#end function main
}
