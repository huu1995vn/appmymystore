// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: DashboardTopWidget(),
            // backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
                children: [
                  RxBuildItem(
                      title: "manager.raoxe".tr(),
                      icon: Icon(Icons.car_rental_rounded),
                      onTap: () => CommonNavigates.toMyProductPage(context),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black45,
                        size: SizeConfig.screenHeight / 21.34,
                      )),
                  RxBuildItem(
                      title: "adv".tr(),
                      icon: Icon(Icons.ad_units_rounded),
                      onTap: () => CommonNavigates.toAdvertPage(context),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black45,
                        size: SizeConfig.screenHeight / 21.34,
                      )),
                  RxBuildItem(
                      title: "manager.address".tr(),
                      icon: Icon(Icons.location_city),
                      onTap: () => CommonNavigates.toContactPage(context),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black45,
                        size: SizeConfig.screenHeight / 21.34,
                      )),
                ],
              ),
          ))
        ],
      ),
    );
  }
}
