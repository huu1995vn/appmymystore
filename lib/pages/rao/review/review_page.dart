// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/rao/review/widgets/item_review.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    super.initState();
    loadData(paging);
  }

  int paging = 1;
  int totalItems = 0;
  List<ReviewModel>? listData;
  AutoScrollController scrollController = AutoScrollController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  loadData([nPaging = 1]) async {
    try {
      nPaging = nPaging ?? 1;
      Map<String, dynamic> body = {
        "p": paging,
        "n": kItemOnPage
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
  dispose() {
    super.dispose();
    if (mounted) scrollController.dispose();
  }

  onDelete(int index) async {
    var item = listData![index];
    Map<String, dynamic> body = {
      "ids": [item.id]
    };
    ResponseModel res = await DaiLyXeApiBLL_APIUser().reviewdelete(body);
    if (res.status > 0) {
      //call api dele
      setState(() {
        listData!.removeAt(index);
      });
    } else {
      CommonMethods.showToast(res.message);
    }
  }

  onDetail([int index = -1]) async {
    ReviewModel item = index > 0 ? listData![index] : ReviewModel();
    CommonNavigates.toReviewPage(context,
        item: item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _key,
      body: RxCustomScrollView(
        appBar: SliverAppBar(
          iconTheme: IconThemeData(
            color: AppColors.black, //change your color here
          ),
          centerTitle: true,
          title: Text('address'.tr(),
              style: kTextHeaderStyle.copyWith(color: AppColors.black)),
          backgroundColor: AppColors.grey,
          elevation: 0.0,
        ),
        key: const Key("LReview"),
        controller: scrollController,
        onNextScroll: onNextPage,
        onRefresh: onRefresh,
        slivers: <Widget>[
          RxSliverList(listData, (BuildContext context, int index) {
            ReviewModel item = listData![index];
            return ItemReviewWidget(item,
                onTap: () => {onDetail(index)},
                onDelete: (context) => onDelete(index));
          })
        ],
      ),
      persistentFooterButtons: [
        RxPrimaryButton(
            onTap: onDetail,
            text: "add.text".tr())
      ],
    );
  }
}
