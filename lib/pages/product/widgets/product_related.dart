// ignore_for_file: empty_catches, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/components/rx_image.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/home/widgets/item_product.widget.dart';

class ProductRelated extends StatefulWidget {
  const ProductRelated(
      {super.key,
      this.filter,
      this.notids,
      this.title,
      this.scrollDirection = Axis.vertical,
      this.scrollController});
  final List<int>? notids;
  final Map<String, dynamic>? filter;
  final String? title;
  final Axis? scrollDirection;
  final ScrollController? scrollController;
  @override
  ReviewState createState() => ReviewState();
}

class ReviewState extends State<ProductRelated> {
  int totalItems = 0;
  int paging = 1;
  List<ProductModel>? listData;
  int userId = APITokenService.userId;
  @override
  initState() {
    super.initState();
    loadData();
  }

  Future loadData([nPaging = 1]) async {
    try {
      var body = <String, dynamic>{};
      body["p"] = nPaging;
      body["n"] = kItemOnPage;
      body["filter"] = widget.filter ?? {};
      if (widget.notids != null) {
        body["filter"]["NotIds"] = widget.notids;
      }
      body["orderBy"] = "VerifyDate DESC";

      if (nPaging == 1) {
        setState(() {
          paging = nPaging;
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
          listData ??= [];
          if (nPaging == 1) {
            listData = list;
          } else {
            listData = (listData! + list);
          }
        });
      }
      paging = nPaging;
    } catch (e) {
      setState(() {
        listData = [];
        totalItems = 0;
      });
    }
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollDirection = widget.scrollDirection ?? Axis.horizontal;
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(kDefaultPaddingBox),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title ?? "NaN",
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              if (scrollDirection == Axis.horizontal)
                RxIconButton(
                    icon: AppIcons.chevron_right,
                    onTap: () {
                      CommonNavigates.toProductPage(context,
                          paramsSearch: widget.filter);
                    })
            ],
          ),
        ),
        RxListView(
          listData,
          (context, index) {
            var item = listData![index];
            return scrollDirection == Axis.horizontal
                ? _buildItem(item)
                : ItemProductWidget(
                    item,
                    onTap: () {
                      CommonNavigates.toProductPage(context, item: item);
                    },
                  );
          },
          key: widget.key,
          scrollController: widget.scrollController,
          noFound: Center(child: Text("no.found".tr)),
          onNextPage: onNextPage,
        ),
      ],
    ));
  }

  Widget _buildItem(ProductModel item) {
    return Card(
      margin: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          CommonNavigates.toProductPage(context, item: item);
        },
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
                                item.price ?? "negotiate".tr),
                            style: kTextPriceStyle),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(item.rxtimeago, style: kTextTimeStyle),
                      ),
                    ]),
              ],
            )),
      ),
    );
  }
}
