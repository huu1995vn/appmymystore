// ignore_for_file: prefer_const_constructors, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/news/widgets/tab_news.widget.dart';

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
    return Scaffold(
        body: DefaultTabController(
      length: tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: Text("news.text".tr()), 
              floating: true,
              automaticallyImplyLeading: false,
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
    ));
  }
}
