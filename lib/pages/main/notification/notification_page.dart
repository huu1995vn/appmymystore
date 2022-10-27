// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/app_provider.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/notification/widgets/item_notification.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
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
    if (!CommonMethods.isLogin) {
      Future.delayed(Duration.zero, () {
        Provider.of<AppProvider>(context, listen: false).setNotification(0);
        setState(() {
          listData = [];
          totalItems = 0;
        });
      });

      return;
    }
    if (nPaging > 1 && listData != null && totalItems <= listData!.length)
      return;
    try {
      nPaging = nPaging ?? 1;
      if (nPaging == 1) {
        setState(() {
          listData = null;
          totalItems = 0;
        });
      }
      Map<String, dynamic> params = {
        "p": nPaging,
        "n": kItemOnPage,
        "orderBy": "CreateDate DESC"
      };
      ResponseModel res = await DaiLyXeApiBLL_APIUser().notification(params);
      if (res.status > 0) {
        List<NotificationModel> list =
            CommonMethods.convertToList<NotificationModel>(
                res.data ?? [], (val) => NotificationModel.fromJson(val));
        Provider.of<AppProvider>(context, listen: false)
            .setNotification(list.isNotEmpty ? list[0].unread : 0);

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
    } catch (e) {
      setState(() {
        listData = [];
        totalItems = 0;
      });
      CommonMethods.showDialogError(context, e);
    }
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  Future<dynamic> onRefresh() async {
    return await loadData();
  }

  _onDelete(index) async {
    if (listData != null && listData!.isNotEmpty) {
      try {
        ResponseModel res = await DaiLyXeApiBLL_APIUser()
            .notificationdelete([listData![index].id]);
        if (res.status > 0) {
          if (listData![index].status == 1) {
            Provider.of<AppProvider>(context, listen: false)
                .minusNotification();
          }
          setState(() {
            listData!.removeAt(index);
          });
          CommonMethods.showToast("success".tr);
        } else {
          CommonMethods.showToast(res.message);
        }
        //Call api gọi api xóa
      } catch (e) {
        CommonMethods.showDialogError(context, e);
      }
    }
  }

  _onDeleteAll() async {
    if (listData != null && listData!.isNotEmpty) {
      var res =
          await CommonMethods.showConfirmDialog(context, "message.alert01".tr);
      if (!res) return;
      try {
        List<int> ids = listData!.map((e) => e.id).toList();
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().notificationdelete(ids);
        if (res.status > 0) {
          CommonMethods.showToast("success".tr);
          loadData();
        } else {
          CommonMethods.showToast(res.message);
        }
        //Call api gọi api xóa
      } catch (e) {
        CommonMethods.showDialogError(context, e);
      }
    }
  }

  _onSeen() async {
    if (listData != null && listData!.isNotEmpty) {
      try {
        List<int> ids = listData!.map((e) => e.id).toList();
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().notificationready(ids);
        if (res.status > 0) {
          CommonMethods.showToast("success".tr);
          loadData();
        } else {
          CommonMethods.showToast(res.message);
        }
        //Call api gọi api xóa
      } catch (e) {
        CommonMethods.showDialogError(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        key: _key,
        body: RxCustomScrollView(
          key: UniqueKey(),
          appBar: SliverAppBar(
            centerTitle: true,
            title: Text('notification'.tr),
            elevation: 0.0,
            floating: true,
            leading: (listData != null && listData!.isNotEmpty)
                ? RxIconButton(
                    icon: AppIcons.playlist_add_check,
                    onTap: _onSeen,
                    size: 50,
                    color: Colors.transparent,
                    colorIcon: Colors.white)
                : Container(),
            actions: <Widget>[
              (listData != null && listData!.isNotEmpty)
                  ? RxIconButton(
                      icon: AppIcons.delete,
                      onTap: _onDeleteAll,
                      size: 40,
                      color: Colors.transparent,
                      colorIcon: Colors.white)
                  : Container(),
              SizedBox(width: kDefaultPadding)
            ],
          ),
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
