// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/dialogs/review.dialog.dart';
import 'package:raoxe/core/components/dialogs/review_all.dialog.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:rating_bar/rating_bar.dart';

class RxReview extends StatefulWidget {
  const RxReview(this.item, {Key? key}) : super(key: key);
  final ProductModel item;

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<RxReview> {
  int totalItems = 0;
  List<ReviewModel>? listData;
  int userId = APITokenService.userId;
  @override
  initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      Map<String, dynamic> body = {"r": widget.item.id, "p": 1, "n": 2};
      ResponseModel res = await DaiLyXeApiBLL_APIGets().review(body);
      if (res.status > 0) {
        List<ReviewModel> list = CommonMethods.convertToList<ReviewModel>(
            res.data, (val) => ReviewModel.fromJson(val));
        setState(() {
          totalItems = (list.length == 0) ? 0 : list[0].rxtotalrow;
          listData = list;
        });
        return;
      } else {}
    } catch (e) {}
    setState(() {
      listData = [];
    });
  }

  _onReview() async {
    var res = await CommonNavigates.showDialogBottomSheet(
        context, ReviewDialog(product: widget.item),
        height: 350);
  }

  viewAll() {
    CommonNavigates.openDialog(
        context,
        ReviewAllDialog(
          product: widget.item,
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double ratingvalue = CommonMethods.convertToDouble(widget.item.ratingvalue);
    double review1 = CommonMethods.convertToDouble(widget.item.review1);
    double review2 = CommonMethods.convertToDouble(widget.item.review2);
    double review3 = CommonMethods.convertToDouble(widget.item.review3);
    double review4 = CommonMethods.convertToDouble(widget.item.review4);
    double review5 = CommonMethods.convertToDouble(widget.item.review5);

    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "$ratingvalue/5",
                  ),
                  RatingBar.readOnly(
                    initialRating: ratingvalue,
                    emptyIcon: AppIcons.star_1,
                    filledIcon: AppIcons.star_1,
                  ),
                  Text(
                    '(${widget.item.reviewcount ?? 0} nhận xét)',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildRating(context, 1,
                      ratingvalue == 0.0 ? 0.0 : (review1 / ratingvalue)),
                  _buildRating(context, 2,
                      ratingvalue == 0.0 ? 0.0 : (review2 / ratingvalue)),
                  _buildRating(context, 3,
                      ratingvalue == 0.0 ? 0.0 : (review3 / ratingvalue)),
                  _buildRating(context, 4,
                      ratingvalue == 0.0 ? 0.0 : (review4 / ratingvalue)),
                  _buildRating(context, 5,
                      ratingvalue == 0.0 ? 0.0 : (review5 / ratingvalue)),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: _onReview,
            child: Container(
                color: Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  "writerreview".tr().toUpperCase(),
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w500),
                )),
          ),
          if (listData != null)
            RxListView(listData, (context, index) {
              var item = listData![index];
              return RxBuildItemReview(item);
            },
                key: Key("writerreview".tr()),
                onRefresh: loadData,
                noFound: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text("not.evaluate".tr()))),
          if (listData != null && totalItems > 2)
            GestureDetector(
              onTap: () {
                viewAll();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${"all".tr()} (${totalItems})",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                    const Icon(
                      AppIcons.chevron_right,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            )
        ]));
  }

  Widget _buildRating(BuildContext context, double rating, double value) {
    return Row(children: <Widget>[
      RatingBar.readOnly(
        initialRating: CommonMethods.convertToDouble(rating ?? 0.0),
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
          value: (value * 100) / 100,
        ),
      ),
      SizedBox(
          width: 50.0,
          child: Text(
            '${(value * 100).toStringAsFixed(2)}%',
          ))
    ]);
  }
}
