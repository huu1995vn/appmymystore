// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/api/index.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/index.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/services/auth.service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/utilities/extensions.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.phone});
  final String phone;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  UserModel? user;
  String passwordAgain = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    if (widget.phone.isNotNullEmpty) {
      setState(() {
        user = UserModel();
        user!.phone = widget.phone;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _header(),
                    _body(),
                  ],
                ))));
  }

  Widget _header() {
    return Center(
      child: Column(
        children: [
          Image.asset(
            CommonConstants.IMAGE_LOGO,
            width: 180,
          ),
          const SizedBox(height: 30),
          MMText(
              data: "regist".tr.toUpperCase(),
              style:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _body() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: MMText(
            data: CommonMethods.convertNumberPhoneWithCountryCode(user!.phone!),
            style: const TextStyle(fontSize: 19).bold,
          )),
          const SizedBox(height: 15),
          Form(
              key: _keyValidationForm,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MMInput(user!.name!,
                      labelText: "fullname".tr,
                      icon: const Icon(AppIcons.user_1),
                      onChanged: (v) => {user!.name = v},
                      validator: Validators.compose([
                        Validators.required("notempty.fullname".tr),
                      ])),
                  MMInput(
                    password,
                    isPassword: true,
                    labelText: "password".tr,
                    icon: const Icon(AppIcons.lock_1),
                    onChanged: (v) => {password = v},
                    validator: Validators.compose([
                      Validators.required("notempty.password".tr),
                      Validators.patternString(
                          MMParttern.password, "invalid.password".tr)
                    ]),
                  ),
                  MMText(
                      data: "message.str004".tr,
                      style: CommonConstants.kTextSubTitleStyle
                          .size(10)
                          .italic
                          .copyWith(color: AppColors.error)),
                  MMInput(
                    passwordAgain,
                    isPassword: true,
                    labelText: "password.again".tr,
                    icon: const Icon(AppIcons.lock_1),
                    validator: (value) {
                      if (value != null && value != password) {
                        return "invalid.password.again".tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              )),
          const SizedBox(height: CommonConstants.kDefaultPadding * 2),
          Row(
            children: [
              Expanded(
                child: MMPrimaryButton(
                    onTap: () {
                      if (_keyValidationForm.currentState!.validate()) {
                        _onRegister();
                      }
                    },
                    text: 'continue'.tr.toUpperCase()),
              )
            ],
          ),
          const SizedBox(height: CommonConstants.kDefaultPadding * 2),
          MMLoginAccountLabel(context)
        ]);
  }

  Future<void> _onRegister() async {
    try {
      // await AuthService.checkPhone(user!.phone, isExist: false);
      // var res = await ApiBLL_APIUser().insertuser(user!.toInsert());
      // if (res.status > 0) {
      //   CommonMethods.showDialogCongratulations(context, "message.str008".tr);
      //   CommonNavigates.toLoginPage(context);
      // } else {
      //   CommonMethods.showToast(res.message);
      // }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }
}
