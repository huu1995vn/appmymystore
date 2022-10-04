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
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/app_provider.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/auth.service.dart';

import '../../../core/commons/common_configs.dart';
import '../../../core/utilities/app_colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  UserModel? data;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    try {
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
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("expand".tr),
          elevation: 0.0,
          actions: <Widget>[
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
        body: data == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Card(
                      margin: EdgeInsets.only(bottom: 5, top: 5),
                      child: Column(children: [_top()])),
                  Card(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Column(
                      children: [
                        _card(
                          child: ListTile(
                            title: Text("manager.raoxe".tr),
                            leading: FaIcon(
                              FontAwesomeIcons.bullhorn,
                            ),
                            onTap: () =>
                                CommonNavigates.toMyProductPage(context),
                            trailing: Icon(
                              AppIcons.keyboard_arrow_right,
                            ),
                            // subtitle: Text("Quản lý danh sách tin rao"),
                          ),
                        ),
                        _card(
                          child: ListTile(
                            title: Text("ads".tr),
                            leading: FaIcon(
                              FontAwesomeIcons.rss,
                            ),
                            onTap: () => CommonNavigates.toAdvertPage(context),
                            trailing: Icon(
                              AppIcons.keyboard_arrow_right,
                            ),
                            // subtitle: Text("Quản lý danh sách quảng cáo"),
                          ),
                        ),
                        _card(
                          child: ListTile(
                            title: Text("contact".tr),
                            leading: FaIcon(
                              FontAwesomeIcons.envelope,
                            ),
                            onTap: () =>
                                CommonNavigates.toVehicleContactPage(context),
                            trailing: Icon(
                              AppIcons.keyboard_arrow_right,
                            ),
                          ),
                        ),
                        _card(
                          child: ListTile(
                            title: Text("favorite".tr),
                            leading: FaIcon(
                              FontAwesomeIcons.heart,
                            ),
                            onTap: () =>
                                CommonNavigates.toFavoritePage(context),
                            trailing: Icon(
                              AppIcons.keyboard_arrow_right,
                            ),
                          ),
                        ),
                        _card(
                          child: ListTile(
                            title: Text("review".tr),
                            leading: FaIcon(
                              FontAwesomeIcons.star,
                            ),
                            onTap: () => CommonNavigates.toReviewPage(context),
                            trailing: Icon(
                              AppIcons.keyboard_arrow_right,
                            ),
                            // subtitle: Text("Danh sách đánh giá"),
                          ),
                        ),
                        _card(
                          child: ListTile(
                            title: Text("address".tr),
                            leading: FaIcon(
                              FontAwesomeIcons.mapPin,
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
                  Card(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Column(children: [
                        _card(
                          child: ListTile(
                            title: Text("Cài đặt"),
                            leading: FaIcon(
                              FontAwesomeIcons.cog,
                            ),
                            onTap: () =>
                                CommonNavigates.toSettingsPage(context),
                            trailing: Icon(
                              AppIcons.keyboard_arrow_right,
                            ),
                            // subtitle: Text("Danh sách đánh giá"),
                          ),
                        )
                      ])),
                ],
              ));
  }

  Widget _card({Widget? child}) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom:
                Get.isDarkMode
                    ? BorderSide(color: Colors.black26, width: 1)
                    : BorderSide(color: Colors.black12, width: 1),
          ),
        ),
        child: child);
  }

  Widget _top() {
    final userProvider = Provider.of<AppProvider>(context);
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: ListTile(
          leading: RxAvatarImage(userProvider.user.rximg!, size: 60),
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
}
