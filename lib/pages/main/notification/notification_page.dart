// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/notification/widgets/item_notification.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  int paging = 1;
  int totalItems = 0;
  List<NotificationModel>? listData;
  AutoScrollController scrollController = AutoScrollController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  loadData([nPaging = 1]) async {
    if (nPaging > 1 && listData != null && totalItems <= listData!.length)
      return;
    nPaging = nPaging ?? 1;
    Map<String, dynamic> params = {"p": nPaging, "n": kItemOnPage, "orderBy": "CreateDate DESC"};
    ResponseModel res = await DaiLyXeApiBLL_APIUser().notification(params);
    if (res.status > 0) {
      List<NotificationModel> list =
          CommonMethods.convertToList<NotificationModel>(
              res.data, (val) => NotificationModel.fromJson(val));
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
      paging = nPaging;
    }
    if ((res.data == null || res.data.length == 0) && nPaging == 1) {
      setState(() {
        listData = [];
        totalItems = 0;
      });
    }
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  Future<dynamic> onRefresh() async {
    return await loadData();
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
            centerTitle: true,
            title: Text('notification.text'.tr(),
                style: kTextHeaderStyle.copyWith(color: AppColors.black)),
            backgroundColor: AppColors.grey,
            floating: true,
            automaticallyImplyLeading: false,
            elevation: 0.0,
          ),
          key: const Key("LNoti"),
          controller: scrollController,
          onNextScroll: onNextPage,
          onRefresh: onRefresh,
          slivers: <Widget>[
            RxSliverList(listData, (BuildContext context, int index) {
              NotificationModel item = listData![index];
              return ItemNotificationWidget(
                listData![index],
                onDelete: (context) => {_onDelete(index)},
                onTap: () {
                  CommonNavigates.toNotificationPage(context,
                      item: item,
                      onChanged: (v) => {
                            setState(() {
                              listData![index] = v;
                            })
                          });
                },
              );
            })
          ],
        ));
  }
}
