// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, import_of_legacy_library_into_null_safe

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:rating_bar/rating_bar.dart';

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
      Map<String, dynamic> body = {
        "r": widget.product.id,
        "p": nPaging,
        "n": kItemOnPage
      };
      ResponseModel res = await DaiLyXeApiBLL_APIGets().review(body);
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
    return await loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RxCustomScrollView(
        key: const Key("lHome"),
        onNextScroll: onNextPage,
        onRefresh: onRefresh,
        appBar: SliverAppBar(
          iconTheme: IconThemeData(
            color: AppColors.black, //change your color here
          ),
          centerTitle: true,
          title: Text('review'.tr(),
              style: kTextHeaderStyle.copyWith(color: AppColors.black)),
          backgroundColor: AppColors.grey,
          elevation: 0.0,
        ),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RatingBar.readOnly(
                      filledColor: AppColors.yellow,
                      size: 25,
                      initialRating: widget.product.ratingvalue,
                      emptyIcon: AppIcons.star_1,
                      filledIcon: AppIcons.star_1,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildRating(context, 1, widget.product.review1),
                    _buildRating(context, 2, widget.product.review2),
                    _buildRating(context, 3, widget.product.review3),
                    _buildRating(context, 4, widget.product.review4),
                    _buildRating(context, 5, widget.product.review5),
                  ],
                ),
              ],
            ),
          ),
          RxSliverList(listData, (BuildContext context, int index) {
            ReviewModel item = listData![index];
            return Card(child: RxBuildItemReview(item));
          })
        ],
      ),
    );
  }

  Widget _buildRating(BuildContext context, double rating, int value) {
    return Row(children: <Widget>[
      RatingBar.readOnly(
        filledColor: AppColors.yellow,
        size: 15,
        initialRating: CommonMethods.convertToDouble(rating),
        filledIcon: AppIcons.star_1,
        emptyIcon: AppIcons.star_1,
      ),
      Container(
        width: 60,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: LinearProgressIndicator(
          backgroundColor: Colors.green[100],
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.success.withOpacity(0.8),
          ),
          value: value.toDouble(),
        ),
      ),
      SizedBox(width: 50.0, child: Text(value.toString()))
    ]);
  }
}
