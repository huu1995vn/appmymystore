// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';

class ReviewAllDialog extends StatefulWidget {
  const ReviewAllDialog({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  State<ReviewAllDialog> createState() => _ReviewAllDialogState();
}

class _ReviewAllDialogState extends State<ReviewAllDialog> {
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
        "filter": {"Status": 1, "ProductId": widget.product}
      };
      ResponseModel res = await DaiLyXeApiBLL_APIUser().review(body);
      if (res.status > 0) {
        List<ReviewModel> list = CommonMethods.convertToList<ReviewModel>(
            res.data, (val) => ReviewModel.fromJson(val));
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.black, //change your color here
          ),
          centerTitle: true,
          title: Text('review'.tr(),
              style: kTextHeaderStyle.copyWith(color: AppColors.black)),
          backgroundColor: AppColors.grey,
          elevation: 0.0,
        ),
        body: RxListView(
          listData,
          (context, index) {
            var item = listData![index];
            return Card(child: RxBuildItemReview(item));
          },
          onNextPage: onNextPage,
          onRefresh: loadData,
          key: widget.key,
        ));
  }
}
