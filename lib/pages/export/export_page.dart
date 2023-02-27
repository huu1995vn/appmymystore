// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/mm_customscrollview.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/components/mm_sliverlist.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/pages/export/widgets/item_export.widget.dart';
import 'package:mymystore/pages/product/widgets/item_product.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ExportPage extends StatefulWidget {
  static String route() => '/export';
  const ExportPage({Key? key}) : super(key: key);

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  @override
  void initState() {
    super.initState();
    loadData(paging);
  }

  int paging = 1;
  int totalItems = 0;
  List<ExportModel> listData = [];
  AutoScrollController scrollController = AutoScrollController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  loadData([nPaging = 1]) async {
    // if (nPaging > 1 && listData != null && totalItems <= listData!.length) {
    //   return;
    // }

    // try {
    //   nPaging = nPaging ?? 1;
    //   if (nPaging == 1) {
    //     setState(() {
    //       listData = null;
    //       totalItems = 0;
    //     });
    //   }
    //   Map<String, dynamic> params = {"p": nPaging, "n": kItemOnPage};
    //   ResponseModel res = await DaiLyXeApiBLL_APIUser().advert(params);
    //   if (res.status > 0) {
    //     List<ExportModel> list = CommonMethods.convertToList<ExportModel>(
    //         res.data, (val) => ExportModel.fromJson(val));
    //     setState(() {
    //       if (nPaging == 1 && (list.isEmpty)) {
    //         totalItems = 0;
    //       }
    //       if (list.isNotEmpty) {
    //         totalItems = list[0].rxtotalrow;
    //       }
    //       listData ??= [];
    //       if (nPaging == 1) {
    //         listData = list;
    //       } else {
    //         listData = (listData! + list);
    //       }
    //     });
    //     paging = nPaging;
    //   } else {
    //     CommonMethods.showToast(res.message);
    //   }
    // } catch (e) {
    //   setState(() {
    //     listData = [];
    //     totalItems = 0;
    //   });
    //   CommonMethods.showDialogError(context, e.toString());
    // }
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  Future<dynamic> onRefresh() async {
    return await loadData();
  }

  @override
  dispose() {
    super.dispose();
    if (mounted) scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: MMText(data: 'product'.tr),
          elevation: 0.0,
        ),
        key: _key,
        body: Container(
            padding: EdgeInsets.only(top: CommonConstants.kDefaultMargin),
            child: MMCustomScrollView(
              key: Key("lProduct"),
              controller: scrollController,
              onNextScroll: onNextPage,
              onRefresh: onRefresh,
              slivers: <Widget>[
                MMSliverList(listData, (BuildContext context, int index) {
                  var item = listData[index];
                  return ItemExportWidget(
                    item,
                    onTap: () =>
                        {CommonNavigates.toExportPage(context, item: item)},
                  );
                })
              ],
            )));
  }
}
