// ignore_for_file: empty_catches, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/components/rx_image.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/pages/main/home/widgets/item_product.widget.dart';

import '../../../core/commons/common_configs.dart';

class ProductRelated extends StatefulWidget {
  const ProductRelated(
      {super.key, this.filter, this.notids, this.title, this.scrollDirection});
  final List<int>? notids;
  final Map<String, dynamic>? filter;
  final String? title;
  final Axis? scrollDirection;
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

  loadData([nPaging = 1]) async {
    try {
      var body = <String, dynamic>{};
      body["p"] = 1;
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
          listData = list ?? [];
          paging = nPaging;
        });
      }
    } catch (e) {
      setState(() {
        paging = 1;

        totalItems = 0;
        listData = [];
      });
    }
  }

  _onNext() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollDirection = widget.scrollDirection ?? Axis.horizontal;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title ?? "NaN",
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.grey[700],
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
          key: UniqueKey(),
          noFound: Center(child: Text("no.found".tr)),
          scrollDirection: scrollDirection,
        ),
        (scrollDirection != Axis.horizontal &&
                listData != null &&
                totalItems > listData!.length)
            ? RxRoundedButton(
                onPressed: _onNext,
                title: "seemore".tr,
                color: AppColors.info,
              )
            : Container()
      ],
    );
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
