// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/news/widgets/item_news.widget.dart';

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
  int totalItems = 0;
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
    if (nPaging > 1 && listData != null && totalItems <= listData!.length) {
      return;
    }

    try {
      nPaging = nPaging ?? 1;
      Map<String, dynamic> params = {
        "id": widget.categorie, // cái này là lại ParentIdList === tin tức mới
        "p": nPaging,
        "n": kItemOnPage
      };
      ResponseModel res = await DaiLyXeApiBLL_APIGets().news(params);
      if (res.status > 0) {
        List<NewsModel> list = CommonMethods.convertToList<NewsModel>(
            res.data, (val) => NewsModel.fromJson(val));
        setState(() {
          if (nPaging == 1 && (list.isEmpty)) {
            totalItems = 0;
          }
          if (list.isNotEmpty) {
            totalItems = list[0].rxtotalrow;
          }
          listData ??= [];
          if (nPaging == 1) {
            listData = list;
          } else {
            listData = (listData! + list);
          }
        });
        paging = nPaging;
      } else {
        CommonMethods.showToast(context, res.message);
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
        var item = listData![index];
        return ItemNewsWidget(
          item,
          onTap: () {
            CommonNavigates.toNewsPage(context, item: item);
          },
        );
      },
      onNextPage: onNextPage,
      onRefresh: loadData,
      key: widget.key,
    );
  }
}
