// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_primary_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/user_provider.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/file.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';

import 'widgets/user_top.widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserModel? data;
  String urlImage = "";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    try {
      ResponseModel res = await DaiLyXeApiBLL_APIUser().getuser();
      if (res.status > 0) {
        setState(() {
          data = UserModel.fromJson(jsonDecode(res.data));
          urlImage = data!.URLIMG;
        });
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }

  Future onUpload() async {
    try {
      File? file = await FileService.getImagePicker(context,
          cropImage: true, circleShape: true);
      if (file == null) return;
      CommonMethods.lockScreen();
      if (file != null) {
        int img = int.parse(data!.img ?? "-1");
        String fullname = data!.fullname;
        int idAvatar =
            await FileService().uploadImage(file, idFile: -1, name: fullname);
        // ignore: curly_braces_in_flow_control_structures
        if (img != idAvatar) {
          ResponseModel res =
              await DaiLyXeApiBLL_APIUser().updateuser(data!.toUpdate());
          data!.img = idAvatar.toString();
          if (res.status > 0) {
            setState(() {
              data!.img = idAvatar.toString();
              APITokenService.img = idAvatar;
            });
          } else {
            CommonMethods.showToast(res.message);
          }
          Provider.of<UserProvider>(context, listen: false).setUserModel(img: idAvatar.toString());
        }
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }

    CommonMethods.unlockScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                    // iconTheme: IconThemeData(
                    //   color: AppColors.primary
                    // ),
                    // backgroundColor: Colors.transparent,
                    expandedHeight: 250.0,
                    flexibleSpace: UserTopWidget(data, onUpload: onUpload)),
                SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                RxBuildItem(
                                    title: "fullname".tr(),
                                    trailing: Text(data!.fullname)),
                                RxBuildItem(
                                    title: "address".tr(),
                                    trailing: Text(data!.address)),
                                RxBuildItem(
                                    title: "birthday".tr(),
                                    trailing: Text(CommonMethods.formatDateTime(
                                        CommonMethods.convertToDateTime(
                                            data!.birthdate)))),
                                RxBuildItem(
                                    title: "gender".tr(),
                                    trailing: Text(
                                      int.parse(data!.gender) == 1
                                          ? "male".tr()
                                          : "female".tr(),
                                    )),
                              ],
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
                          ],
                        )))
              ],
            ),
    );
  }
}
