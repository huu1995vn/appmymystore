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
        backgroundColor: Colors.grey[200],
        body: DefaultTabController(
          length: tabs.length,
          child: NestedScrollView(
<<<<<<< HEAD
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  title: Text("manager.raoxe".tr),
                  elevation: 0.0,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: RxSliverAppBarTabDelegate(
                    child: PreferredSize(
                      preferredSize: Size.fromHeight(45.0),
                      child: Container(
                        color: Colors.white,
                        child: TabBar(
                          isScrollable: true,
                          labelColor: AppColors.primary,
                          unselectedLabelColor: AppColors.black50,
                          indicatorColor: AppColors.primary,
                          tabs: tabs,
=======
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    centerTitle: true,
                    title: Text("manager.raoxe".tr()),
                    elevation: 0.0,
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: RxSliverAppBarTabDelegate(
                      child: PreferredSize(
                        preferredSize: Size.fromHeight(45.0),
                        child: Container(
                          color: Colors.white,
                          child: TabBar(
                            isScrollable: true,
                            labelColor: AppColors.primary,
                            unselectedLabelColor: AppColors.black50,
                            indicatorColor: AppColors.primary,
                            tabs: tabs,
                          ),
>>>>>>> 0498dceafad2ebd3fb54ad525dce6152642a8a65
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(children: tabviews)),
        ),
        persistentFooterButtons: [
          RxPrimaryButton(
              onTap: onAdd, icon: Icon(AppIcons.plus_circle), text: "add".tr)
        ]);
  }
}
