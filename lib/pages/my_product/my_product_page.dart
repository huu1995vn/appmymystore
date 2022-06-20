// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_rounded_button.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/pages/my_product/widgets/tab_my_product.widget.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text("manager.raoxe".tr(),
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    )),
                elevation: 0.0,
                //Cách 1
                // bottom: PreferredSize(
                //     child: TabBar(
                //         isScrollable: true,
                //         unselectedLabelColor: Colors.white.withOpacity(0.3),
                //         indicatorColor: Colors.white,
                //         tabs: tabs),
                //     preferredSize: Size.fromHeight(30.0)),
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
            children: [
              TabMyProductWidget(status: 1),
              TabMyProductWidget(status: 2),
              TabMyProductWidget(status: 3),
              TabMyProductWidget(status: 4)
            ],
          ),
        ),
      ),
    );
  }
}

