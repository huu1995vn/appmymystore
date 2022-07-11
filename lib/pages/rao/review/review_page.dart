// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/rao/review/widgets/tab_review.widget.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  List<Widget> tabs = <Widget>[];
  List<Widget> tabviews = <Widget>[];

  loadData() {
    setState(() {
      tabs = PRODUCTREVIEWSTATUS
          .map((item) => Tab(
                child: Text(item.categoryname),
              ))
          .toList();
      tabviews = PRODUCTREVIEWSTATUS
          .map(
            (item) => TabReviewWidget(status: item.id),
          )
          .toList();
    });
  }

  int itemselect = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text("review".tr(), style: kTextHeaderStyle),
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
    );
  }
}
