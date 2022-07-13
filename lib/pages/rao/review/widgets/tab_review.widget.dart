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
import 'package:raoxe/pages/rao/review/widgets/item_review.widget.dart';

class TabReviewWidget extends StatefulWidget {
  dynamic status;
  TabReviewWidget({this.status = 1});
  @override
  State<TabReviewWidget> createState() => _TabReviewWidgetPageState();
}

class _TabReviewWidgetPageState extends State<TabReviewWidget>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<TabReviewWidget> {
  @override
  bool get wantKeepAlive => true;

  List<dynamic>? listData;
  int paging = 1;
  int totalItems = 0;
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
    if (nPaging > 1 && listData != null && totalItems! <= listData!.length)
      return;

    try {
      nPaging = nPaging ?? 1;
      Map<String, dynamic> body = {
        "p": nPaging,
        "n": kItemOnPage,
        "filter": {"Status": widget.status}
      };
      ResponseModel res = await DaiLyXeApiBLL_APIUser().review(body);
      if (res.status > 0) {
        List<ReviewModel> list = CommonMethods.convertToList<ReviewModel>(
            res.data, (val) => ReviewModel.fromJson(val));
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
        var item = listData![index];
        return ItemReviewWidget(item,
            onTap: () =>
                {CommonNavigates.toProductPage(context, id: item.productid)});
      },
      onNextPage: onNextPage,
      onRefresh: loadData,
      key: widget.key,
    );
  }
}
