// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/rao/advert/widgets/item_advert.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class AdvertPage extends StatefulWidget {
  const AdvertPage({Key? key}) : super(key: key);

  @override
  State<AdvertPage> createState() => _AdvertPageState();
}

class _AdvertPageState extends State<AdvertPage> {
  @override
  void initState() {
    super.initState();
    loadData(paging);
  }

  int paging = 1;
  int totalItems = 0;
  List<AdvertModel>? listData;
  AutoScrollController scrollController = AutoScrollController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  loadData(nPaging) async {
    try {
      nPaging = nPaging ?? 1;
      Map<String, dynamic> params = {
        "id": 2, // cái này là lại ParentIdList === tin tức mới
        "p": paging,
        "n": kItemOnPage
      };
      ResponseModel res = await DaiLyXeApiBLL_APIUser().advertlist(params);
      if (res.status > 0) {
        List<dynamic> data = jsonDecode(res.data);
        List<AdvertModel> newslist =
            data.map((val) => AdvertModel.fromJson(val)).toList();
        setState(() {
          totalItems =
              newslist.isNotEmpty ? int.parse(newslist[0].TotalRow) : 0;
          listData ??= [];
          if (nPaging == 1) {
            listData = newslist;
          } else {
            listData = (listData! + newslist);
          }
        });
        paging = nPaging;
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  Future<dynamic> onRefresh() async {
    return await loadData(1);
  }

  @override
  dispose() {
    super.dispose();
    if (mounted) scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        body: RxCustomScrollView(
          appBar: SliverAppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color, //change your color here
            ),
            centerTitle: true,
            title: Text('adv'.tr(),
                style: kTextHeaderStyle.copyWith(
                    color: Theme.of(context).textTheme.bodyText1!.color)),
            elevation: 0.0,
            backgroundColor: AppColors.grey,
          ),
          key: const Key("LAdv"),
          controller: scrollController,
          onNextScroll: onNextPage,
          onRefresh: onRefresh,
          slivers: <Widget>[
            RxSliverList(listData, (BuildContext context, int index) {
              return ItemAdvertWidget(listData![index]);
            })
          ],
        ));
  }
}
