// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/rao/my_product/widgets/item_my_product.widget.dart';

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
      ResponseModel res = await DaiLyXeApiBLL_APIUser().product(body);
      if (res.status > 0) {
        List<ProductModel> list = CommonMethods.convertToList<ProductModel>(
            res.data, (val) => ProductModel.fromJson(val));
        setState(() {
          totalItems =
              (nPaging == 1 && list.length == 0) ? 0 : list[0].rxtotalrow;
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
        return ItemMyProductWidget(item,
            onTap: () => {
                  CommonNavigates.toMyProductPage(context,
                      item: item,
                      onChanged: (v) => {
                            setState(() {
                              listData![index] = item;
                            })
                          })
                });
      },
      onNextPage: onNextPage,
      onRefresh: loadData,
      key: widget.key,
    );
  }
}
