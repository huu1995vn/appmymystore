// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/my_product/widgets/item_my_product.widget.dart';

class TabMyProductWidget extends StatefulWidget {
  dynamic status;
  TabMyProductWidget({this.status = 1});
  @override
  State<TabMyProductWidget> createState() => _TabMyProductWidgetPageState();
}

class _TabMyProductWidgetPageState extends State<TabMyProductWidget>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<TabMyProductWidget> {
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
        "id": 2, // cái này là lại ParentIdList === tin tức mới
        "p": paging,
        "n": kItemOnPage
      };
      ResponseModel res = await DaiLyXeApiBLL_APIUser().advertlist(params);
      if (res.status > 0) {
        List<dynamic> data = jsonDecode(res.data);
        List<ProductModel> newslist =
            data.map((val) => ProductModel.fromJson(val)).toList();
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
        return ItemMyProductWidget(listData![index]);
      },
      onNextPage: onNextPage,
      onRefresh: loadData,
      key: widget.key,
    );
  }
}
