// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/notifycation/widgets/item_notifycation.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class NotifycationPage extends StatefulWidget {
  const NotifycationPage({Key? key}) : super(key: key);

  @override
  State<NotifycationPage> createState() => _NotifycationPageState();
}

class _NotifycationPageState extends State<NotifycationPage> {
  @override
  void initState() {
    super.initState();
    loadData(paging);
  }

  int paging = 1;
  int totalItems = 0;
  List<NewsModel>? listData;
  AutoScrollController scrollController = AutoScrollController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  loadData(nPaging) async {
    nPaging = nPaging ?? 1;
    Map<String, dynamic> params = {
      "id": 2, // cái này là lại ParentIdList === tin tức mới
      "p": paging,
      "n": kItemOnPage
    };
    ResponseModel res = await DaiLyXeApiBLL_APIGets().news(params);
    List<dynamic> data = jsonDecode(res.data);
    List<NewsModel> list = data.map((val) => NewsModel.fromJson(val)).toList();
    setState(() {
      totalItems = list[0].rxtotalrow;
      listData ??= [];
      if (nPaging == 1) {
        listData = list;
      } else {
        listData = (listData! + list);
      }
    });
    paging = nPaging;
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  Future<dynamic> onRefresh() async {
    return await loadData(1);
  }

  _onDelete(index) {
    //Call api gọi api xóa
    setState(() {
      listData!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        key: _key,
        body: RxCustomScrollView(
          appBar: SliverAppBar(
            iconTheme: IconThemeData(
              color: AppColors.black, //change your color here
            ),
            title: Text('notification.text'.tr(),
                style: kTextHeaderStyle.copyWith(
                    color: AppColors.black)),
            floating: true,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: AppColors.grey,
          ),
          key: const Key("LNoti"),
          controller: scrollController,
          onNextScroll: onNextPage,
          onRefresh: onRefresh,
          slivers: <Widget>[
            RxSliverList(listData, (BuildContext context, int index) {
              return ItemNotifycationWidget(listData![index],
                  onDelete: (context) => {_onDelete(index)});
            })
          ],
        ));
  }
}
