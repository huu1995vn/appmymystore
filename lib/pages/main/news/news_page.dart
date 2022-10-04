// ignore_for_file: prefer_const_constructors, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/news/widgets/tab_news.widget.dart';

import '../../../core/commons/common_configs.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> tabs = CATEGORIES
      .map((item) => Tab(
            child: Text(item.categoryname),
          ))
      .toList();
  List<Widget> tabviews = CATEGORIES
      .map(
        (item) => TabNewsWidget(parentid: item.id),
      )
      .toList();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text("news".tr),
                automaticallyImplyLeading: false,
                elevation: 0.0,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: ColoredBox(
                    color:Get.isDarkMode ? Colors.white10 : Colors.white,
                    child: TabBar(
                      isScrollable: true,
                      labelColor: AppColors.primary,
                      unselectedLabelColor:
                          Get.isDarkMode ? Colors.white : AppColors.black,
                      indicatorColor: Colors.red[800],
                      tabs: tabs,
                    ),
                  ),
                )),
            body: TabBarView(
              children: tabviews,
            )));
  }
}
