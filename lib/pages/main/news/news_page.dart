// ignore_for_file: prefer_const_constructors, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/news/widgets/tab_news.widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);
  @override
  State<NewsPage> createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: CATEGORIES.length, vsync: this);
  }

  List<Widget> tabs = CATEGORIES
      .map((item) => Tab(
            child: Text(item.categoryname),
          ))
      .toList();

  List<Widget> tabviews = CATEGORIES.map((item) {
    return TabNewsWidget(parentid: item.id, key: UniqueKey());
  }).toList();
  bool isloading = false;
  loadData() {
    // (tabviews[_tabController!.index] as TabNewsWidget).getState.scrollController.jumpTo(0);
    setState(() {
      isloading = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("news".tr),
        elevation: 0.0,
      ),
      body: isloading
          ? Container(key: UniqueKey())
          : DefaultTabController(
              length: tabs.length,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: RxSliverAppBarTabDelegate(
                          child: PreferredSize(
                              preferredSize: Size.fromHeight(50),
                              child: ColoredBox(
                                color: Get.isDarkMode
                                    ? Colors.white10
                                    : Colors.white,
                                child: TabBar(
                                  isScrollable: true,
                                  labelColor: AppColors.primary,
                                  unselectedLabelColor: Get.isDarkMode
                                      ? Colors.white
                                      : AppColors.black,
                                  indicatorColor: Colors.red[800],
                                  tabs: tabs,
                                  controller: _tabController,
                                ),
                              ))),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: tabviews,
                ),
              ),
            ),
    );
  }
}
