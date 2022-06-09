// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_card.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:raoxe/pages/main/dashboard/widgets/top_custom_shape.dart';
import 'package:raoxe/pages/main/dashboard/widgets/user_sections.dart';

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
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TopCustomShape(),
      SizedBox(
        height: SizeConfig.screenHeight / 34.15,
      ),
      RxBuildItem(
          title: "My information",
          icon: Icon(Icons.account_circle),
          onTap: () => CommonNavigates.toUserPage(context),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black45,
            size: SizeConfig.screenHeight! / 21.34,
          )),
      RxBuildItem(
          title: "Products",
          icon: Icon(Icons.car_crash_sharp),
          onTap: () {},
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black45,
            size: SizeConfig.screenHeight! / 21.34,
          )),
      RxBuildItem(
          title: "Promotions",
          icon: Icon(Icons.shopping_basket),
          onTap: () {},
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black45,
            size: SizeConfig.screenHeight! / 21.34,
          )),
      RxBuildItem(
          title: "Address information",
          icon: Icon(Icons.location_city),
          onTap: () {},
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black45,
            size: SizeConfig.screenHeight! / 21.34,
          )),
      RxBuildItem(
          title: "Settings",
          icon: Icon(Icons.settings),
          onTap: () => CommonNavigates.toSettingsPage(context),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black45,
            size: SizeConfig.screenHeight! / 21.34,
          )),
    ]));
  }
}
