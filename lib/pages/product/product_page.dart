// ignore_for_file: prefer_const_constructors, unused_local_variable, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/home/widgets/item_product.widget.dart';
import 'package:raoxe/pages/product/widgets/list_brand.widget.dart';
import 'package:raoxe/pages/product/widgets/search_app_bar.dart';

class ProductPage extends StatefulWidget {
  Map<String, dynamic>? paramsSearch;
  ProductPage({super.key, this.paramsSearch});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      paramsSearch = widget.paramsSearch ?? {};
      loadData();
    });
  }

  int paging = 1;
  int totalItems = 0;
  List<ProductModel>? listData;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Map<String, dynamic> paramsSearch = {};
  loadData([npaging = 1]) async {
    if (listData != null && npaging > 1 && totalItems <= listData!.length)
      // ignore: curly_braces_in_flow_control_structures
      return;
    paging = npaging ?? 1;
    var params = Map<String, dynamic>.from(paramsSearch);
    params["p"] = paging;
    params["n"] = kItemOnPage;
    ResponseModel res = await DaiLyXeApiBLL_APIGets().product(params);
    List<dynamic> data = res.data;
    // ignore: unnecessary_cast
    List<ProductModel> list = data
        .map((val) => ProductModel.fromJson(val))
        .toList() as List<ProductModel>;
    if (mounted) {
      setState(() {
        totalItems = list[0].rxtotalrow;
        listData;
        if (paging == 1) {
          listData = list;
        } else {
          listData = (listData! + list);
        }
      });
    }
    paging = paging;
  }

  Future onNextPage() async {
    loadData(paging + 1);
  }

  Future onRefresh() async {
    loadData();
  }

  _onChanged(params) async {
    setState(() {
      paramsSearch = params;
      loadData();
    });
  }

  _onBrandChange(v) {
    setState(() {
      paramsSearch["brand"] = v;
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.black, //change your color here
          ),
          title: SearchAppBar(
            paramsSearch: paramsSearch ?? {},
            onChanged: _onChanged,
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        key: _key,
        body: RxCustomScrollView(
          // ignore: prefer_const_literals_to_create_immutables
          slivers: [
            SliverToBoxAdapter(
                child: ListBrandWidget(
                    onPressed: (v) => {_onBrandChange(v)},
                    value: paramsSearch["brand"])),
            RxSliverList(listData, (BuildContext context, int index) {
              var item = listData![index];
              return ItemProductWidget(listData![index], onTap: () {
                CommonNavigates.toProductPage(context, id: item.id);
              });
            })
          ],
          key: const Key("LProcduct"),
          onNextScroll: onNextPage,
          onRefresh: onRefresh,
        ));
    ;
  }
}
