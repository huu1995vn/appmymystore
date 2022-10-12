// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, prefer_is_empty, non_constant_identifier_names

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/dialogs/address.dialog.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/app_provider.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/product/widgets/product_related.dart';
import 'package:raoxe/pages/rao/user/dialogs/change_email.dialog.dart';
import 'package:raoxe/pages/rao/user/dialogs/change_password.dialog.dart';
import 'package:raoxe/pages/rao/user/dialogs/info.dialog.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, this.id});
  final int? id;
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserModel? data;
  String urlImage = "";
  int id = -1;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool isMyUser = false;
  loadData() async {
    try {
      id = widget.id ?? APITokenService.userId;
      isMyUser = id == APITokenService.userId;
      ResponseModel res = await DaiLyXeApiBLL_APIGets().getuserbyid(id);
      if (res.status > 0) {
        var user = UserModel.fromJson(res.data);
        setState(() {
          id = id;
          data = user;
          urlImage = data!.rximg;
        });
        if (isMyUser) {
          Provider.of<AppProvider>(context, listen: false).setUserModel(user);
        }
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }

  _onEdit() {
    if (!isMyUser) {
      return;
    }
    CommonNavigates.openDialog(context, InfoUserDiaLog(data: data!));
  }

  _onChangePassword() {
    if (!isMyUser) {
      return;
    }
    CommonNavigates.openDialog(context, ChangePasswordDiaLog(data: data!));
  }

  _onChangeAddress() async {
    if (!isMyUser) {
      return;
    }
    var res = await CommonNavigates.openDialog(
      context,
      AddressDialog(contact: data!.toContact()),
    );

    if (res != null) {
      setState(() {
        data!.cityid = res.cityid;
        data!.districtid = res.districtid;
        data!.address = res.address;
      });
      CommonMethods.lockScreen();
      try {
        var dataClone = data!.clone();
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().updateuser(dataClone.toUpdate());
        if (res.status > 0) {
          setState(() {
            data = dataClone;
          });
          CommonMethods.showToast("success".tr);
        } else {
          CommonMethods.showToast(res.message);
        }
        Provider.of<AppProvider>(context, listen: false)
            .setUserModel(dataClone);
      } catch (e) {
        CommonMethods.showDialogError(context, e.toString());
      }

      CommonMethods.unlockScreen();
    }
  }

  _onChangeEmail() async {
    if (!isMyUser) {
      return;
    }
    var email = await CommonNavigates.openDialog(
        context, ChangeEmailDiaLog(data: data!));
    if (email != null) {
      CommonMethods.showToast("success".tr);
    }
    loadData();
  }

  _onVerifyEmail() async {
    try {
      bool checkOtp = await CommonNavigates.openOtpVerificationEmailDialog(
          context, data!.email!);
      if (checkOtp != null && checkOtp) {
        CommonMethods.showToast("success".tr);
        loadData();
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }

  _onVerifyPhone() async {
    try {
      bool checkOtp = await CommonNavigates.openOtpVerificationPhoneDialog(
          context, data!.phone!, true);
      if (checkOtp != null && checkOtp) {
        CommonMethods.lockScreen();
        try {
          ResponseModel res = await DaiLyXeApiBLL_APIUser().verifyphone();
          if (res.status > 0) {
            CommonMethods.showToast("success".tr);
            loadData();
          } else {
            CommonMethods.showToast(res.message);
          }
        } catch (e) {
          CommonMethods.showDialogError(context, e.toString());
        }

        CommonMethods.unlockScreen();
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  centerTitle: true,
                  title: Text("personalinformation".tr),
                  elevation: 0.0,
                ),
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.only(bottom: kDefaultMarginBottomBox),
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (isMyUser)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: kDefaultPaddingBox),
                                            child: GestureDetector(
                                                onTap: _onEdit,
                                                child: FaIcon(
                                                  FontAwesomeIcons.edit,
                                                  color: Theme.of(context).textTheme.bodyLarge!.color,
                                                )),
                                          )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    CircleAvatar(
                                      radius: 60.0,
                                      // backgroundColor: AppColors.white,
                                      backgroundImage: const AssetImage(
                                          'assets/loading_icon.gif'),
                                      child: CircleAvatar(
                                        // backgroundColor: Colors.white,
                                        child: Container(),
                                        radius: 60.0,
                                        backgroundImage: RxImageProvider(
                                            isMyUser
                                                ? userProvider.user.rximg
                                                : data!.rximg),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      data!.fullname!.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    if (isMyUser)
                                      Column(
                                        children: [
                                          if (data!.email != null &&
                                              !data!.verifyemail)
                                            GestureDetector(
                                                onTap: _onVerifyEmail,
                                                child: Text(
                                                  "verify.email".tr,
                                                  style: TextStyle(
                                                      color: AppColors.danger),
                                                )),
                                          if (data!.phone != null &&
                                              !data!.verifyphone)
                                            GestureDetector(
                                                onTap: _onVerifyPhone,
                                                child: Text(
                                                  "verify.phone".tr,
                                                  style: TextStyle(
                                                      color: AppColors.danger),
                                                )),
                                        ],
                                      ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              )
                            ],
                          ), 
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.only(bottom: kDefaultMarginBottomBox),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(kDefaultPaddingBox),
                            child: Text("info".tr,
                                style: TextStyle(
                                    // color: Get.isDarkMode
                                    //     ? Colors.white
                                    //     : Colors.grey[700],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                          if (data!.phone != "")
                            RxBorderListTile(
                                child: ListTile(
                                    title: Text(data!.phone! ?? "NaN"),
                                    leading: FaIcon(
                                      FontAwesomeIcons.phone,
                                    ))),
                          if (data!.email != "")
                            RxBorderListTile(
                                child: ListTile(
                                    title: Text(data!.email! ?? "NaN"),
                                    leading: FaIcon(
                                      FontAwesomeIcons.solidEnvelope,
                                    ),
                                    trailing: !isMyUser
                                        ? null
                                        : GestureDetector(
                                            onTap: _onChangeEmail,
                                            child: FaIcon(
                                              FontAwesomeIcons.edit,
                                            )))),
                          if (data!.address != "")
                            RxBorderListTile(
                                child: ListTile(
                                    title: Text(data!.address! ?? "NaN",
                                        style: TextStyle(fontSize: 16)),
                                    leading: FaIcon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                    ),
                                    trailing: !isMyUser
                                        ? null
                                        : GestureDetector(
                                            onTap: _onChangeAddress,
                                            child: FaIcon(
                                              FontAwesomeIcons.edit,
                                            ),
                                          ))),
                          if (isMyUser)
                            RxBorderListTile(
                                child: ListTile(
                                    title: Text("change.password".tr),
                                    leading: FaIcon(
                                      FontAwesomeIcons.lock,
                                    ),
                                    trailing: !isMyUser
                                        ? null
                                        : GestureDetector(
                                            onTap: _onChangePassword,
                                            child: FaIcon(
                                              FontAwesomeIcons.edit,
                                            )))),
                        ],
                      ),
                    ),
                    ProductRelated(
                      title: "news.post".tr,
                      filter: {"UserId": id},
                      scrollDirection: Axis.vertical,
                    )
                  ],
                ))
              ],
            ),
    );
  }
}
