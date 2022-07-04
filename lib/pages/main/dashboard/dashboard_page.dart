// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/providers/user_provider.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';

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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: Center(
              child: Text(
                "Dashboard",
                style: kTextHeaderStyle.size(39),
              ),
            ),
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    _top(),
                    _card(
                      child: ListTile(
                        title: Text("manager.raoxe".tr()),
                        leading: Icon(
                            AppIcons.car,
                            color: AppColors.primary,
                          ),
                        onTap: () => CommonNavigates.toMyProductPage(context),
                        // subtitle: Text("Quản lý danh sách tin rao"),
                      ),
                    ),
                    _card(
                      child: ListTile(
                        title: Text("adv".tr()),
                        leading: Icon(
                          AppIcons.cart,
                          color: AppColors.yellow,
                        ),
                        onTap: () => CommonNavigates.toAdvertPage(context),
                        // subtitle: Text("Quản lý danh sách quảng cáo"),
                      ),
                    ),
                    _card(
                      child: ListTile(
                        title: Text("Favorite"),
                        leading: Icon(
                          AppIcons.heart_1,
                          color: AppColors.red,
                        ),
                        onTap: () => CommonNavigates.toContactPage(context),
                        // subtitle: Text("Sản phẩm yêu thích"),
                      ),
                    ),
                    _card(
                      child: ListTile(
                        title: Text("evaluate".tr()),
                        leading: Icon(
                          AppIcons.star_1,
                          color: AppColors.yellow,
                        ),
                        onTap: () => CommonNavigates.toContactPage(context),
                        // subtitle: Text("Danh sách đánh giá"),
                      ),
                    ),
                    _card(
                      child: ListTile(
                        title: Text("address".tr()),
                        leading: Icon(
                          AppIcons.map_marker,
                          color: AppColors.info,
                        ),
                        onTap: () => CommonNavigates.toContactPage(context),
                        // subtitle: Text("Sổ địa chỉ"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _card({Widget? child}) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        child: child);
  }

  Widget _top() {
    final userProvider = Provider.of<UserProvider>(context);
    return ListTile(
      leading: RxAvatarImage(userProvider.urlImage!, size: 40),
      title: InkWell(
          onTap: () {
            CommonNavigates.toUserPage(context);
          },
          child: Text(
            userProvider.fullname!,
            style: const TextStyle(
              fontSize: 19,
            ),
          )),
      trailing: InkWell(
          onTap: () {
            CommonNavigates.toSettingsPage(context);
          },
          child: Icon(
            AppIcons.cog_1,
            color: Theme.of(context).textTheme.bodyText1!.color,
            // size: 19,
          )),
      onTap: () => {},
    );
  }
}
