// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/app_provider.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/auth.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  UserModel data = UserModel();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    try {
      if (CommonMethods.isLogin) {
        ResponseModel res =
            await DaiLyXeApiBLL_APIGets().getuserbyid(APITokenService.userId);
        if (res.status > 0) {
          UserModel user = UserModel.fromJson(res.data);
          setState(() {
            data = user;
          });
          Provider.of<AppProvider>(context, listen: false).setUserModel(user);
        } else {
          CommonMethods.showToast(res.message);
        }
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("expand".tr),
          elevation: 0.0,
          actions: <Widget>[
            if (CommonMethods.isLogin)
              TextButton(
                onPressed: () {
                  AuthService.logout(context);
                },
                child: Text(
                  "logout".tr,
                  style: TextStyle(color: Colors.white),
                ),
              )
          ],
        ),
        body: _body());
  }

  List<Widget> _logined() {
    final appProvider = Provider.of<AppProvider>(context);
    return [
      Card(
          margin: EdgeInsets.only(bottom: 5, top: 5),
          child: Column(children: [_top()])),
      Card(
        margin: EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            RxBorderListTile(
              child: ListTile(
                title: Text("manager.raoxe".tr),
                leading: Container(
                  width: 25,
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.bullhorn,
                  ),
                ),
                subtitle: !appProvider.user.verifyphone
                    ? Text(
                        "message.str017".tr,
                        style: TextStyle(color: AppColors.danger),
                      )
                    : Container(),
                onTap: () {
                  appProvider.user.verifyphone
                      ? CommonNavigates.toMyProductPage(context)
                      : CommonNavigates.toUserPage(context);
                },
                trailing: Icon(
                  AppIcons.keyboard_arrow_right,
                ),
                // subtitle: Text("Quản lý danh sách tin rao"),
              ),
            ),
            RxBorderListTile(
              child: ListTile(
                title: Text("ads".tr),
                leading: Container(
                  width: 25,
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.rss,
                  ),
                ),
                onTap: () => CommonNavigates.toAdvertPage(context),
                trailing: Icon(
                  AppIcons.keyboard_arrow_right,
                ),
                // subtitle: Text("Quản lý danh sách quảng cáo"),
              ),
            ),
            RxBorderListTile(
              child: ListTile(
                title: Text("contact".tr),
                leading: Container(
                  width: 25,
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.solidEnvelope,
                  ),
                ),
                onTap: () => CommonNavigates.toVehicleContactPage(context),
                trailing: Icon(
                  AppIcons.keyboard_arrow_right,
                ),
              ),
            ),
            RxBorderListTile(
              child: ListTile(
                title: Text("bookmark".tr),
                leading: Container(
                  width: 25,
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.solidBookmark,
                  ),
                ),
                onTap: () => CommonNavigates.toFavoritePage(context),
                trailing: Icon(
                  AppIcons.keyboard_arrow_right,
                ),
              ),
            ),
            RxBorderListTile(
              child: ListTile(
                title: Text("review".tr),
                leading: Container(
                  width: 25,
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.solidStar,
                  ),
                ),
                onTap: () => CommonNavigates.toReviewPage(context),
                trailing: Icon(
                  AppIcons.keyboard_arrow_right,
                ),
                // subtitle: Text("Danh sách đánh giá"),
              ),
            ),
            RxBorderListTile(
              child: ListTile(
                title: Text("address".tr),
                leading: Container(
                  width: 25,
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.mapMarkerAlt,
                  ),
                ),
                onTap: () => CommonNavigates.toContactPage(context),
                trailing: Icon(
                  AppIcons.keyboard_arrow_right,
                ),
                // subtitle: Text("Sổ địa chỉ"),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _notlogin() {
    final userProvider = Provider.of<AppProvider>(context);
    return [
      Card(
        margin: EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: ListTile(
                  leading: RxCircleAvatar(
                    backgroundColor: Get.isDarkMode ? Colors.black12 :  Colors.grey,
                    child: FaIcon(FontAwesomeIcons.user, color:AppColors.black50),
                  ),
                  title: Text(
                    "${"login".tr} / ${"regist".tr}",
                    style: const TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  subtitle: Text("welcome".tr),
                  trailing: Icon(AppIcons.keyboard_arrow_right),
                  onTap: () {
                    CommonNavigates.toLoginPage(context);
                  },
                )),
          ],
        ),
      ),
    ];
  }

  List<Widget> _public() {
    return [
      Card(
          margin: EdgeInsets.only(bottom: 5),
          child: Column(children: [
            RxBorderListTile(
              child: ListTile(
                title: Text("setting".tr),
                leading: Container(
                  width: 25,
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.cog,
                  ),
                ),
                onTap: () => CommonNavigates.toSettingsPage(context),
                trailing: Icon(
                  AppIcons.keyboard_arrow_right,
                ),
                // subtitle: Text("Danh sách đánh giá"),
              ),
            )
          ])),
    ];
  }

  Widget _top() {
    final userProvider = Provider.of<AppProvider>(context);
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: ListTile(
          leading: RxAvatarImage(userProvider.user.rximg, size: 60),
          title: InkWell(
              onTap: () {
                CommonNavigates.toUserPage(context);
              },
              child: Text(
                userProvider.user.fullname!,
                style: const TextStyle(
                  fontSize: 19,
                ),
              )),
          trailing: Icon(AppIcons.keyboard_arrow_right),
        ));
  }

  Widget _body() {
    return Column(children: [
      ...(CommonMethods.isLogin ? _logined() : _notlogin()),
      ..._public()
    ]);
  }
}
