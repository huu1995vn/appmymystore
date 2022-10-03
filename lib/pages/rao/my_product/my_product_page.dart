// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text("manager.raoxe".tr()),
                elevation: 0.0,
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: ColoredBox(
                      color: Colors.white,
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.red[900],
                        labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        unselectedLabelColor: AppColors.black50,
                        indicatorColor: Colors.red[800],
                        tabs: tabs,
                      ),
                    ))),
            body: TabBarView(children: tabviews),
            persistentFooterButtons: [
              RxPrimaryButton(
                  onTap: onAdd,
                  icon: Icon(AppIcons.plus_circle),
                  text: "add.text".tr())
            ]));
  }
}
