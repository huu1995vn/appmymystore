// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, prefer_is_empty, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/dialogs/address.dialog.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
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
    CommonNavigates.openDialog(context, ChangeEmailDiaLog(data: data!));
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
                        child: SizedBox(
                          height: 170,
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
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
                                  ],
                                ),
                              )
                            ],
                          ),
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
                            child: Text("personalinformation".tr,
                                style: TextStyle(
                                    // color: Get.isDarkMode
                                    //     ? Colors.white
                                    //     : Colors.grey[700],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                          RxBorderListTile(
                              child: ListTile(
                                  title: Text(data!.phone! ?? "NaN"),
                                  leading: FaIcon(
                                    FontAwesomeIcons.phone,
                                  ))),
                          RxBorderListTile(
                              child: ListTile(
                                  title: Text(data!.email! ?? "NaN"),
                                  leading: FaIcon(
                                    FontAwesomeIcons.solidEnvelope,
                                  ),
                                  onTap: _onChangeEmail,
                                  trailing: !isMyUser
                                      ? null
                                      : Icon(
                                          AppIcons.keyboard_arrow_right,
                                        ))),
                          RxBorderListTile(
                              child: ListTile(
                                  title: Text(data!.address! ?? "NaN"),
                                  leading: FaIcon(
                                    FontAwesomeIcons.mapPin,
                                  ),
                                  onTap: _onChangeAddress,
                                  trailing: !isMyUser
                                      ? null
                                      : Icon(
                                          AppIcons.keyboard_arrow_right,
                                        ))),
                          if (isMyUser)
                            RxBorderListTile(
                                child: ListTile(
                              title: Text("change.password".tr),
                              leading: FaIcon(
                                FontAwesomeIcons.lock,
                              ),
                              onTap: _onChangePassword,
                              trailing: !isMyUser
                                  ? null
                                  : Icon(
                                      AppIcons.keyboard_arrow_right,
                                    ),
                            )),
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

  // Widget _top() {
  //   final userProvider = Provider.of<AppProvider>(context);
  //   return ListTile(
  //     leading: RxAvatarImage(isMyUser ? userProvider.user.rximg : data!.rximg,
  //         size: 50),
  //     title: Text(
  //       isMyUser ? userProvider.user.fullname! : data!.fullname!,
  //       style: const TextStyle(
  //         fontSize: 19,
  //       ),
  //     ),
  //     trailing:
  //         isMyUser ? RxIconButton(icon: AppIcons.edit, onTap: _onEdit) : null,
  //   );
  // }
}
