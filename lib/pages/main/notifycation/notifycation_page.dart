// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/news/widgets/item_news.widget.dart';
import 'package:raoxe/pages/main/notifycation/widgets/item_notifycation.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class NotifycationPage extends StatefulWidget {
  const NotifycationPage({Key? key}) : super(key: key);

  @override
  State<NotifycationPage> createState() => _NotifycationPageState();
}

class _NotifycationPageState extends State<NotifycationPage> {
  @override
  void initState() {
    super.initState();
    loadData(paging);
  }

  int paging = 1;
  int totalItems = 0;
  List<NewsModel>? listData;
  AutoScrollController scrollController = AutoScrollController();
  final GlobalKey<FormState> _tinTucKey = GlobalKey<FormState>();

  loadData(nPaging) async {
    nPaging = nPaging ?? 1;
    Map<String, dynamic> params = {
      "id": 2, // cái này là lại ParentIdList === tin tức mới
      "p": paging,
      "n": kItemOnPage
    };
    ResponseModel res = await DaiLyXeApiBLL_Page().news(params);
    List<dynamic> data = jsonDecode(res.data["newslist"]);
    List<NewsModel> newslist =
        data.map((val) => NewsModel.fromJson(val)).toList() as List<NewsModel>;
    setState(() {
      totalItems = newslist.isNotEmpty ? int.parse(newslist[0].TotalRow) : 0;
      listData ??= [];
      if (nPaging == 1) {
        listData = newslist;
      } else {
        listData = (listData! + newslist)!;
      }
    });
    paging = nPaging;
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  Future<dynamic> onRefresh() async {
    return await loadData(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _tinTucKey,
        // backgroundColor: Colors.grey[200],
        body: RxListView(
          listData,
          (BuildContext context, int index) {
            return ItemNotifycationWidget(listData![index]);
          },
          totalItems,
          appBar: SliverAppBar(
            title: Text('notification.text'.tr(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                )),
            floating: true,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            // leading: Container(child: null),
          ),
          key: const Key("LTinTuc"),
          controller: scrollController,
          onNextPage: onNextPage,
          onRefresh: onRefresh,
        ));
  }
}
