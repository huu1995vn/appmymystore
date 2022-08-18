// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/rx_slider.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/constants.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  int paging = 1;
  int totalItems = 0;
  List<BannerModel> listData = [];
  loadData([nPaging = 1]) async {
    List<BannerModel> list = [];
    try {
      ResponseModel res = await DaiLyXeApiBLL_APISite().getBanner();
      if (res.data == null) return;
      list = CommonMethods.convertToList<BannerModel>(
          json.decode(res.data), (val) => BannerModel.fromJson(val));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (list.isEmpty || list.isEmpty) {
      for (var element in kBanners) {
        BannerModel item = BannerModel();
        item.src = CommonMethods.buildUrlImage(int.parse(element),
                rewriteUrl: "banner-raoxe");
        list.add(item);
      }
    }
    setState(() {
      listData = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RxSlider(
      onTap: (i) {
        var item = listData[i];
        if (item.link != null && CommonMethods.isURl(item.link!)) {
          CommonMethods.launchURL(item.link!);
        }
      },
      items: listData.map((e) => e.src.toString()).toList(),
    );
  }
}
