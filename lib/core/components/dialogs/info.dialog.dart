// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_input.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/user_provider.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class InfoDialog extends StatefulWidget {
  InfoDialog({super.key});
  @override
  State<InfoDialog> createState() => _SearchPageState();
}

class _SearchPageState extends State<InfoDialog> {
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  UserModel data = UserModel();
  String passwordAgain = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: SingleChildScrollView(
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
            Text("save".tr(), style: const TextStyle(color: AppColors.white))
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
                RxInput(data.fullname,
                    labelText: "fullname".tr(),
                    icon: const Icon(Icons.person),
                    onChanged: (v) => {
                          setState(() => {data.username = v})
                        },
                    validator: Validators.compose([
                      Validators.required("notempty.fullname.text".tr()),
                    ])),
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
                        _onSave();
                      }
                    },
                  ),
                ), //button: login
                RxLoginAccountLabel(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    CommonMethods.lockScreen();
    try {
      ResponseModel res =
          await DaiLyXeApiBLL_APIUser().updateuser(data.toUpdate());
      if (res.status > 0) {
        setState(() {
          data = data;
        });
        Provider.of<UserProvider>(context, listen: false)
            .setUserModel(fullname: data.fullname, img: data.img, id: data.id);
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
    CommonMethods.unlockScreen();
  }
}
