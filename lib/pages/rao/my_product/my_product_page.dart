// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
  }

  int itemselect = 1;
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
                  title: Text("manager.raoxe".tr(),
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      )),
                  elevation: 0.0,
                  centerTitle: true,
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
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: tabviews,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: _buttonAdd());
  }

  Widget _buttonAdd() {
    return Container(
        width: 55.0,
        height: 55.0,
        decoration: kBoxDecorationStyle.copyWith(
            borderRadius: BorderRadius.circular(30.0)),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          elevation: 0.0,
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
          onPressed: () {
            CommonNavigates.toMyProductPage(context, item: ProductModel());
          },
        ));
  }
}
