// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_primary_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:raoxe/pages/user/widgets/item_child.dart';

import 'widgets/top_custom_shape.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserModel? data;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    loadData();
  }

  loadData() async {
    try {
      ResponseModel res = await DaiLyXeApiBLL_APIRaoXe().get();
      if (res.status > 0) {
        data = UserModel.fromJson(jsonDecode(res.data));
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary800,
          elevation: 0.0,
        ),
        body: data == null
            ? Container()
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TopCustomShape(),
                // SizedBox(
                //   height: SizeConfig.screenHeight / 34.15,
                // ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight / 34.15,
                      ),
                      ItemChild("fullname".tr(), value: data!.fullname),
                      RxDivider(),
                      ItemChild("address".tr(), value: data!.address),
                      RxDivider(),
                      ItemChild("birthday".tr(),
                          value: data!.birthdate.toString()
                          // CommonMethods.formatDate(data.birthdate, "dd/MM/yyyy"),
                          ),
                      RxDivider(),
                      ItemChild(
                        "gender".tr(),
                        value: data!.gender ? "male".tr() : "female".tr(),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: SizedBox(
                      width: SizeConfig.screenWidth / 2,
                      child: RxPrimaryButton(
                        text: 'edit.text'.tr(),
                        onTap: () {},
                      ),
                    ),
                  ),
                )
              ]));
  }
}
