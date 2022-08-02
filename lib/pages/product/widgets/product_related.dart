// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/rx_image.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/constants.dart';

class ProductRelated extends StatefulWidget {
  const ProductRelated(this.item, {Key? key, this.filter}) : super(key: key);
  final ProductModel item;
  final Map<String, dynamic>? filter;

  @override
  ReviewState createState() => ReviewState();
}

class ReviewState extends State<ProductRelated> {
  int totalItems = 0;
  List<ProductModel>? listData;
  int userId = APITokenService.userId;
  @override
  initState() {
    super.initState();
    loadData();
  }

  loadData([nPaging = 1]) async {
    try {
      var body = <String, dynamic>{};
      body["p"] = 1;
      body["n"] = kItemOnPage;
      body["filter"] = widget.filter ?? {};
      body["filter"]["NotIds"] = widget.item.id;
      body["orderBy"] = "VerifyDate DESC";

      if (nPaging == 1) {
        setState(() {
          listData = null;
        });
      }
      ResponseModel res = await DaiLyXeApiBLL_APIGets().product(body);
      List<ProductModel> list = CommonMethods.convertToList<ProductModel>(
          res.data, (val) => ProductModel.fromJson(val));
      if (mounted) {
        setState(() {
          if (nPaging == 1 && (list.isEmpty)) {
            totalItems = 0;
          }
          if (list.isNotEmpty) {
            totalItems = list[0].rxtotalrow;
          }
          listData = list ?? [];
        });
      }
    } catch (e) {
      setState(() {
        totalItems = 0;
        listData = [];
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: (listData != null && listData!.length == 0) ? 50 : 200,
          child: RxListView(
            listData,
            (context, index) {
              var item = listData![index];
              return _buildItem(item);
            },
            key: Key("review".tr()),
            noFound: Center(child: Text("nodatafound".tr())),
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }

  Widget _buildItem(ProductModel item) {
    return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Card(
          margin: EdgeInsets.zero,
          child: InkWell(
              onTap: () {
                CommonNavigates.toProductPage(context, item: item);
              },
              child: SizedBox(
                width: (MediaQuery.of(context).size.width / 3 - 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                  height: 80,
                                  decoration: const BoxDecoration(),
                                  child: RxImage(
                                    item.rximg,
                                    fit: BoxFit.cover,
                                  )),
                              Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Text(
                                    item.name! ?? "",
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                    CommonMethods.formatNumber(
                                        item.price ?? "negotiate".tr()),
                                    style: kTextPriceStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child:
                                    Text(item.rxtimeago, style: kTextTimeStyle),
                              ),
                            ]),
                      ],
                    )),
              )),
        ));
  }
}
