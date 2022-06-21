// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/news/widgets/item_news.widget.dart';
import 'package:raoxe/pages/rao/my_product/widgets/item_my_product.widget.dart';

class TabNewsWidget extends StatefulWidget {
  dynamic categorie;
  TabNewsWidget({this.categorie = 1});
  @override
  State<TabNewsWidget> createState() => _TabNewsWidgetPageState();
}

class _TabNewsWidgetPageState extends State<TabNewsWidget>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<TabNewsWidget> {
  @override
  bool get wantKeepAlive => true;

  List<dynamic>? listData;
  int paging = 1;
  int? totalItems;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadData([nPaging = 1]) async {
    try {
      nPaging = nPaging ?? 1;
      Map<String, dynamic> params = {
        "id": widget.categorie, // cái này là lại ParentIdList === tin tức mới
        "p": paging,
        "n": kItemOnPage
      };
      ResponseModel res = await DaiLyXeApiBLL_APIGets().newslist(params);
      if (res.status > 0) {
        List<dynamic> data = jsonDecode(res.data);
        List<NewsModel> newslist =
            data.map((val) => NewsModel.fromJson(val)).toList();
        setState(() {
          totalItems =
              newslist.isNotEmpty ? int.parse(newslist[0].TotalRow) : 0;
          listData ??= [];
          if (nPaging == 1) {
            listData = newslist;
          } else {
            listData = (listData! + newslist);
          }
        });
        paging = nPaging;
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  Future<dynamic> onRefresh() async {
    return await loadData(1);
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    super.build(context);
    return RxListView(
      listData,
      (context, index) {
        return ItemNewsWidget(listData![index]);
      },
      onNextPage: onNextPage,
      onRefresh: loadData,
      key: widget.key,
    );
  }
}