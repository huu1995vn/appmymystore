// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:raoxe/pages/main/dashboard/widgets/dashboard_top.widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // CommonMethods.lockScreen();
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DashboardTopWidget(),
      Expanded(
          child: RxWrapper(
              body: Column(
        children: [
          RxBuildItem(
              title: "personalinformation".tr(),
              icon: Icon(Icons.account_circle),
              onTap: () => CommonNavigates.toUserPage(context),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black45,
                size: SizeConfig.screenHeight/ 21.34,
              )),
          RxBuildItem(
              title: "manager.raoxe".tr(),
              icon: Icon(Icons.car_crash_sharp),
              onTap: () {},
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black45,
                size: SizeConfig.screenHeight/ 21.34,
              )),
          RxBuildItem(
              title: "offer".tr(),
              icon: Icon(Icons.shopping_basket),
              onTap: () {},
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black45,
                size: SizeConfig.screenHeight/ 21.34,
              )),
          RxBuildItem(
              title: "manager.address".tr(),
              icon: Icon(Icons.location_city),
              onTap: () {},
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black45,
                size: SizeConfig.screenHeight/ 21.34,
              )),
          RxBuildItem(
              title: "setting".tr(),
              icon: Icon(Icons.settings),
              onTap: () => CommonNavigates.toSettingsPage(context),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black45,
                size: SizeConfig.screenHeight/ 21.34,
              )),
        ],
      )))
    ]));
  }
}
