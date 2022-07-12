// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_images.dart';
import 'package:raoxe/core/components/rx_review.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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

  onFavorite() async {
    try {
      CommonMethods.onFavorite([data!.id], !data!.isfavorite);
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: isNotFound
          ? Expanded(child: Center(child: Text("not.found".tr())))
          : (data == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RxCustomScrollView(
                  key: const Key("iProduct"),
                  controller: scrollController,
                  slivers: <Widget>[
                    SliverAppBar(
                      iconTheme: IconThemeData(
                        color: AppColors.black, //change your color here
                      ),
                      title: Image.asset(
                        LOGORAOXECOLORIMAGE,
                        width: 100,
                      ),
                      centerTitle: true,
                      elevation: 0.0,
                      backgroundColor: AppColors.grey,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(
                            AppIcons.heart_1,
                            color: data!.isfavorite ? AppColors.primary : null,
                          ),
                          onPressed: onFavorite,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: AppColors.black50,
                          ),
                          tooltip: 'Share',
                          onPressed: () {
                            // onSetting(context);
                          },
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(child: _buildDetail())
                  ],
                )),
      persistentFooterButtons: [
        if (data != null)
          GestureDetector(
            onTap: () {},
            child: Container(
              height: kSizeHeight,
              decoration: kBoxDecorationStyle.copyWith(
                  borderRadius: BorderRadius.circular(5)),
              alignment: Alignment.center,
              child: Icon(AppIcons.phone_handset, color: AppColors.white),
            ),
          ),
        // if (data != null)
        //   GestureDetector(
        //     onTap: () {},
        //     child: Container(
        //       decoration: BoxDecoration(color: AppColors.grey),
        //       width: SizeConfig.screenWidth * 0.13,
        //       height: kSizeHeight,
        //       alignment: Alignment.center,
        //       child: Icon(AppIcons.envelope, color: AppColors.yellow),
        //     ),
        //   )
      ],
    );
  }

  Widget _listTitle(String title, dynamic? subtitle, {Widget? leading}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          if (leading != null) leading,
          Text(
            "$title: ",
            style: kTextTitleStyle,
          ),
          Text(
            subtitle?.toString() ?? "not.update".tr(),
            style: TextStyle(color: AppColors.primary),
          )
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
          // color: AppColors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RxAvatarImage(data!.rximguser, size: 40),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  data!.fullname!,
                  style: const TextStyle(
                    color: AppColors.black50,
                  ).bold.size(12),
                ),
                Row(
                  children: [
                    Icon(
                      AppIcons.map_marker,
                      color: AppColors.black50,
                      size: 13,
                    ),
                    Text(
                      data!.address!,
                      style: const TextStyle(
                        color: AppColors.black50,
                      ).size(12),
                    ),
                  ],
                )
              ]),
            ],
          ),
        ),
        Card(
            child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data!.name ?? "",
                    style: kTextHeaderStyle.copyWith(fontSize: 17),
                    maxLines: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(CommonMethods.formatNumber(data!.price ?? "Liên hệ"),
                        style: kTextPriceStyle),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      AppIcons.clock_1,
                      color: AppColors.black50,
                      size: 13,
                    ),
                    Text(data!.rxtimeago,
                        style:
                            TextStyle(fontSize: 13, color: AppColors.black50)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: kDefaultPadding, right: kDefaultPadding),
                  child: TextFormField(
                    initialValue: data!.des,
                    minLines:
                        6, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                )
              ],
            ),
          ),
        )),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                _listTitle("madein".tr(), data!.madeinname),
                _listTitle("model".tr(), data!.modelname),
                _listTitle("bodytype".tr(), data!.bodytypename),
                _listTitle("fueltype".tr(), data!.fueltypename),
                _listTitle("color".tr(), data!.colorname),
                _listTitle("year".tr(), data!.year),
                _listTitle("seat".tr(), data!.seat),
                _listTitle("door".tr(), data!.door),
                _listTitle("km".tr(), data!.km),
              ],
            ),
          ),
        ),
        // Card(
        //   child: ListTile(
        //     leading: GestureDetector(
        //       onTap: () {},
        //       child: RxAvatarImage(data!.rximguser ?? NOIMAGEUSER, size: 40),
        //     ),
        //     title: GestureDetector(
        //       onTap: () {},
        //       child: Text(data!.fullname ?? "",
        //           style: const TextStyle().bold),
        //     ),
        //     subtitle: Row(
        //       // spacing: kDefaultPadding,
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(
        //           data!.address!,
        //           style: const TextStyle(
        //             color: AppColors.black50,
        //           ).bold.size(12),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 120,
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
                      "message.str012".tr(),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          // onReport(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.grey,
                          minimumSize: const Size.fromHeight(36), // NEW
                        ),
                        icon: Icon(
                          AppIcons.warning,
                          color: AppColors.yellow,
                        ),
                        label: Text(
                          "report.text".tr().toUpperCase(),
                          style: TextStyle(color: AppColors.yellow).bold,
                        )),
                  ],
                ))
              ],
            ),
          ),
        ),
        Card(child: RxReview(data!))
      ],
    );
  }
}
