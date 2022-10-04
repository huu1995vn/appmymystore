// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_null_comparison, import_of_legacy_library_into_null_safe, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/dialogs/report.dialog.dart';
import 'package:raoxe/core/components/dialogs/review.dialog.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/components/rx_images.dart';
import 'package:raoxe/pages/product/widgets/product_related.dart';
import 'package:raoxe/pages/product/widgets/product_review.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../core/commons/common_configs.dart';

class ProductDetailPage extends StatefulWidget {
  final int? id;
  final ProductModel? item;
  const ProductDetailPage({super.key, this.id, this.item});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  AutoScrollController scrollController = AutoScrollController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // String title = "";
  String? initialUrl;
  ProductModel? data;
  bool isNotFound = false;
  loadData() async {
    try {
      if (widget.item != null) {
        setState(() {
          data = widget.item!;
        });
      } else {
        ResponseModel res =
            await DaiLyXeApiBLL_APIGets().productbyid(widget.id!);
        if (res.status > 0) {
          setState(() {
            data = ProductModel.fromJson(res.data);
          });
        } else {
          setState(() {
            isNotFound = true;
          });
          CommonMethods.showToast(res.message);
        }
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
  }

  _onFavorite() async {
    try {
      var res = await CommonMethods.onFavorite(
          context, [data!.id], !data!.isfavorite);
      setState(() {
        data = data;
      });
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
  }

  _onReview() async {
    if (!CommonMethods.isLogin) {
      CommonMethods.showToast("please.login".tr);
      return;
    }
    await CommonNavigates.showDialogBottomSheet(
        context, ReviewDialog(product: data!),
        height: 400);
  }

  _onShare() {
    CommonMethods.share(data!.linkshare);
  }

  _onReport() async {
    if (!CommonMethods.isLogin) {
      CommonMethods.showToast("please.login".tr);
      return;
    }
    await CommonNavigates.showDialogBottomSheet(
        context, ReportDialog(product: data!),
        height: 420);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isNotFound
            ? Expanded(child: Center(child: Text("not.found".tr)))
            : ((data == null || data!.id <= 0)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RxCustomScrollView(
                    key: const Key("iProduct"),
                    controller: scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        title: Text(data!.name ?? "updating".tr),
                        elevation: 0.0,
                        actions: <Widget>[
                          RxIconButton(
                              icon: data!.isfavorite
                                  ? FontAwesomeIcons.solidBookmark
                                  : FontAwesomeIcons.bookmark,
                              onTap: _onFavorite,
                              size: 40,
                              color: Colors.transparent,
                              colorIcon: data!.isfavorite
                                  ? AppColors.yellow
                                  : AppColors.white),
                          SizedBox(width: kDefaultPadding),
                          RxIconButton(
                            icon: FontAwesomeIcons.solidShareFromSquare,
                            size: 40,
                            color: Colors.transparent,
                            colorIcon: AppColors.white,
                            onTap: _onShare,
                          ),
                          SizedBox(width: kDefaultPadding),
                        ],
                      ),
                      SliverToBoxAdapter(child: _buildDetail())
                    ],
                  )),
        bottomNavigationBar: Container(
            padding: EdgeInsets.all(0.0),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: GestureDetector(
                      onTap: () => {CommonMethods.call(data!.phone!)},
                      child: Container(
                          height: 50,
                          padding: EdgeInsets.all(10),
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.phone,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: kDefaultPadding),
                              Text(
                                "call".tr + ": " + (data!.phone)!,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ))),
                ),
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                      onTap: () => {CommonMethods.chatZalo(data!.phone!)},
                      child: Container(
                          height: 50,
                          padding: EdgeInsets.all(5),
                          color: Colors.grey[100],
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.comment,
                                  color: Colors.grey[700]),
                              Text("chatzalo".tr,
                                  style: TextStyle(color: Colors.grey[700]))
                            ],
                          ))),
                ),
              ],
            )));
  }

  Widget _listTitle(String title, dynamic subtitle, {Widget? leading}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
      child: Row(
        children: [
          if (leading != null) leading,
          SizedBox(width: 10),
          SizedBox(
              width: 100,
              child: Text(
                " $title: ",
                style: kTextTitleStyle,
              )),
          Text(
              (subtitle is int
                      ? (subtitle > 0 ? subtitle.toString() : null)
                      : subtitle?.toString()) ??
                  "not.update".tr,
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget _buildDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RxImages(data: data!.rximglist),
        Card(
            margin: EdgeInsets.only(bottom: 5),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data!.name ?? "",
                        style: kTextHeaderStyle.copyWith(fontSize: 20),
                        maxLines: 2),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(data!.rxprice ?? "negotiate".tr,
                            style: kTextPriceStyle.copyWith(fontSize: 25)),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: data!.state == 1
                                  ? Colors.blue
                                  : Colors.yellow,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Text(data!.statename,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: data!.state == 1
                                        ? Colors.white
                                        : Colors.black)))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(data!.rxtimeago, style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        Card(
            margin: EdgeInsets.only(bottom: 5),
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Row(
                children: [
                  Icon(
                    AppIcons.map_1,
                    size: 13,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text(data!.address ?? "NaN",
                          style: TextStyle(fontSize: 13)))
                ],
              ),
            )),
        Card(
          margin: EdgeInsets.only(bottom: 5),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("specification".tr,
                        style: TextStyle(
                            // color: Get.isDarkMode
                            //     ? Colors.white
                            //     : Colors.grey[700],
                            fontSize: 18,
                            fontWeight: FontWeight.bold))),
                SizedBox(
                  height: 5,
                ),
                _listTitle("model".tr, data!.modelname,
                    leading:
                        FaIcon(FontAwesomeIcons.car, color: AppColors.primary)),
                _listTitle("bodytype".tr, data!.bodytypename,
                    leading: FaIcon(FontAwesomeIcons.carSide,
                        color: AppColors.primary)),
                _listTitle("color".tr, data!.colorname,
                    leading: FaIcon(FontAwesomeIcons.palette,
                        color: AppColors.primary)),
                _listTitle("seat".tr, data!.seat,
                    leading: Icon(AppIcons.airline_seat_legroom_normal,
                        color: AppColors.primary)),
                _listTitle("fueltype".tr, data!.fueltypename,
                    leading: FaIcon(FontAwesomeIcons.gasPump,
                        color: AppColors.primary)),
                _listTitle("year".tr, data!.year,
                    leading: FaIcon(FontAwesomeIcons.calendar,
                        color: AppColors.primary)),
                _listTitle("madein".tr, data!.madeinname,
                    leading: FaIcon(FontAwesomeIcons.circleInfo,
                        color: AppColors.primary)),
              ],
            ),
          ),
        ),
        Card(
            margin: EdgeInsets.only(bottom: 5),
            child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("description".tr,
                              style: TextStyle(
                                  // color: Get.isDarkMode
                                  //     ? Colors.white
                                  //     : Colors.grey[700],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))),
                      TextFormField(
                          initialValue: data!.desc,
                          minLines:
                              6, // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          enabled: false),
                    ]))),
        Card(
          margin: EdgeInsets.only(bottom: 5),
          child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RxAvatarImage(data!.rximguser, size: 50),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            CommonNavigates.toUserPage(context,
                                id: data!.userid);
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data!.fullname ?? "NaN",
                                  style: TextStyle(
                                    fontSize: 16,
                                    // color: Get.isDarkMode
                                    //     ? Colors.white
                                    //     : AppColors.black50,
                                  ).bold,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      data!.cityname ?? "NaN",
                                      style: TextStyle(
                                          // color: Get.isDarkMode
                                          //     ? Colors.white
                                          //     : AppColors.black50,
                                          ),
                                    ),
                                  ],
                                )
                              ])),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RxIconButton(
                          icon: data!.isfavorite
                              ? FontAwesomeIcons.solidBookmark
                              : FontAwesomeIcons.bookmark,
                          onTap: _onFavorite,
                          size: 40,
                          color: Colors.black45,
                          colorIcon: data!.isfavorite
                              ? AppColors.yellow
                              : AppColors.white),
                      SizedBox(width: kDefaultPadding),
                      RxIconButton(
                        icon: FontAwesomeIcons.solidShareFromSquare,
                        size: 40,
                        color: Colors.black45,
                        colorIcon: AppColors.white,
                        onTap: _onShare,
                      ),
                      GestureDetector(
                          onTap: _onReview,
                          child: Text(
                            "review".tr,
                            style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.info)
                                .underline,
                          )),
                    ],
                  )
                ],
              )),
        ),
        Card(
            margin: EdgeInsets.only(bottom: 5),
            child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("rate".tr,
                            style: TextStyle(
                                // color: Get.isDarkMode
                                //     ? Colors.white
                                //     : Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.bold))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(CommonMethods.convertToString(data!.ratingvalue),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 10,
                        ),
                        RatingBar.readOnly(
                          filledColor: AppColors.yellow,
                          emptyColor: AppColors.yellow,
                          size: 30,
                          initialRating: data!.ratingvalue,
                          isHalfAllowed: true,
                          emptyIcon: FontAwesomeIcons.star,
                          filledIcon: FontAwesomeIcons.solidStar,
                          halfFilledIcon: FontAwesomeIcons.starHalfStroke,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      RxButton(
                        icon: Icon(AppIcons.edit),
                        color: Colors.blue,
                        onTap: _onReview,
                        text: "writereview".tr,
                      ),
                    ])
                  ],
                ))),
        Card(
          // color: Get.isDarkMode ? AppColors.blackLight : Colors.white,
          margin: EdgeInsets.only(bottom: 5),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 80,
                  child: Icon(
                    AppIcons.security,
                    size: 50,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "message.str001".tr,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: kDefaultPadding),
                      child: RxButton(
                          onTap: _onReport,
                          icon: Icon(
                            AppIcons.warning,
                          ),
                          color: AppColors.black50,
                          text: "report".tr.toUpperCase()),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
        ProductReview(data!),
        Card(
            margin: EdgeInsets.only(bottom: 5),
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: ProductRelated(
                      title: "news.brand".tr,
                      filter: {"BrandId": data!.brandid},
                      scrollDirection: Axis.vertical,
                      notids: [data!.id]),
            ))
      ],
    );
  }
}
