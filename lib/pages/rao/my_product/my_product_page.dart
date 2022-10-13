// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/rao/my_product/widgets/tab_my_product.widget.dart';

class MyProductPage extends StatefulWidget {
  const MyProductPage({Key? key}) : super(key: key);

  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  List<Widget> tabs = <Widget>[];
  List<Widget> tabviews = <Widget>[];

  loadData() {
    setState(() {
      tabs = PRODUCTSTATUS
          .map((item) => Tab(
                child: Text(item.categoryname),
              ))
          .toList();
      tabviews = PRODUCTSTATUS
          .map(
            (item) => TabMyProductWidget(status: item.id),
          )
          .toList();
    });
  }

  int itemselect = 1;
  Future<dynamic> onAdd() async {
    var res = await CommonNavigates.toMyProductPage(context,
        item: ProductModel(), onChanged: (v) => {loadData()});
    if (res != null) {
      setState(() {
        tabs = [];
        tabviews = [];
      });
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
          length: tabs.length,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  title: Text("manager.raoxe".tr),
                  elevation: 0.0,
                  floating: false,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: RxSliverAppBarTabDelegate(
                      child: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: ColoredBox(
                            color:
                                Get.isDarkMode ? Colors.white10 : Colors.white,
                            child: TabBar(
                              isScrollable: true,
                              labelColor: AppColors.primary,
                              unselectedLabelColor: Get.isDarkMode
                                  ? Colors.white
                                  : AppColors.black,
                              indicatorColor: Colors.red[800],
                              tabs: tabs,
                            ),
                          ))),
                ),
              ];
            },
            body: TabBarView(
              children: tabviews,
            ),
          ),
        ),
        persistentFooterButtons: [
          Row(children: [
            Expanded(
                child: RxPrimaryButton(
                    onTap: onAdd,
                    icon: Icon(AppIcons.plus_circle),
                    text: "add".tr))
          ])
        ]);
  }
}
