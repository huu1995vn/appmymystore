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

  bool isAwaiting = false;
  List<Widget> tabs = PRODUCTSTATUS
      .map((item) => Tab(
            child: Text(item.categoryname),
          ))
      .toList();
  List<Widget> tabviews = PRODUCTSTATUS
      .map(
        (item) => TabMyProductWidget(status: item.id),
      )
      .toList();
  loadData() {
    setState(() {
      isAwaiting = true;
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isAwaiting = false;
      });
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

  Widget _bodylist_awaiting() {
    return ListView.builder(
        key: UniqueKey(),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: kDefaultPadding),
        itemCount: kItemOnPage,
        itemBuilder: (context, index) {
          return RxCardSkeleton(barCount: 3, isShowAvatar: false);
        });
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
            body: isAwaiting
                ? _bodylist_awaiting()
                : TabBarView(
                    children: tabviews,
                  ),
          ),
        ),
        persistentFooterButtons: [
          if (!isAwaiting)
            RxPrimaryButton(
                onTap: onAdd,
                icon: Icon(AppIcons.plus_circle),
                text: "add".tr)
        ]);
  }
}
