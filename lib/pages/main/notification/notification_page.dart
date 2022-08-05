// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/notification_provider.dart';
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
    try {
      if (nPaging > 1 && listData != null && totalItems <= listData!.length)
        return;
      nPaging = nPaging ?? 1;
      Map<String, dynamic> params = {
        "p": nPaging,
        "n": kItemOnPage,
        "orderBy": "CreateDate DESC"
      };
      ResponseModel res = await DaiLyXeApiBLL_APIUser().notification(params);
      if (res.status > 0) {
        List<NotificationModel> list =
            CommonMethods.convertToList<NotificationModel>(
                res.data, (val) => NotificationModel.fromJson(val));
        if (list.length > 0) {
          Provider.of<NotificationProvider>(context, listen: false)
              .setNotification(list[0].unread);
        }

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
    if (listData != null && listData!.length > 0) {
      try {
        ResponseModel res = await DaiLyXeApiBLL_APIUser()
            .notificationdelete([listData![index].id]);
        if (res.status > 0) {
          if (listData![index].status == 1) {
            Provider.of<NotificationProvider>(context, listen: false)
                .minusNotification();
          }
          setState(() {
            listData!.removeAt(index);
          });
        } else {
          CommonMethods.showToast(context, res.message);
        }
        //Call api gọi api xóa

      } catch (e) {
        CommonMethods.showDialogError(context, e);
      }
    }
  }

  _onDeleteAll() async {
    if (listData != null && listData!.length > 0) {
      try {
        List<int> ids = listData!.map((e) => e.id).toList();
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().notificationdelete(ids);
        if (res.status > 0) {
          loadData();
        } else {
          CommonMethods.showToast(context, res.message);
        }
        //Call api gọi api xóa

      } catch (e) {
        CommonMethods.showDialogError(context, e);
      }
    }
  }

  _onSeen() async {
    if (listData != null && listData!.length > 0) {
      try {
        List<int> ids = listData!.map((e) => e.id).toList();
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().notificationready(ids);
        if (res.status > 0) {
          loadData();
        } else {
          CommonMethods.showToast(context, res.message);
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
            actions: <Widget>[
              PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: TextButton.icon(
                        onPressed: _onDeleteAll,
                        icon: Icon(
                          AppIcons.delete,
                          color: AppColors.black50,
                        ),
                        label: Text("delete.text".tr(),
                            style: TextStyle(color: AppColors.black50))),
                  ),
                  PopupMenuItem(
                    value: 0,
                    child: TextButton.icon(
                        onPressed: _onSeen,
                        icon: Icon(AppIcons.eye_1, color: AppColors.black50),
                        label: Text("seen".tr(),
                            style: TextStyle(color: AppColors.black50))),
                  ),
                ],
              )
            ],
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
