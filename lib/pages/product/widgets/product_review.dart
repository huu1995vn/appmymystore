// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/dialogs/review_all.dialog.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/constants.dart';

class ProductReview extends StatefulWidget {
  const ProductReview(this.item, {Key? key}) : super(key: key);
  final ProductModel item;

  @override
  ReviewState createState() => ReviewState();
}

class ReviewState extends State<ProductReview> {
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
    return (listData == null || listData!.length == 0)
        ? Container()
        : Card(
            child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(children: <Widget>[
                  if (listData != null)
                    RxListView(listData, (context, index) {
                      var item = listData![index];
                      return RxBuildItemReview(item);
                    },
                        key: Key("review".tr()),
                        onRefresh: loadData,
                        noFound: Container()),
                  if (listData != null)
                    GestureDetector(
                      onTap: () {
                        viewAll();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: kDefaultPadding),
                        child: Text(
                          "${"all".tr()} ${totalItems > 0 ? "($totalItems)" : ""}",
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                ])));
  }
}
