// ignore_for_file: prefer_const_constructors, empty_catches, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/app_provider.dart';

import '../../../app_icons.dart';
import '../../../core/commons/common_navigates.dart';
import '../../../core/components/rx_icon_button.dart';

class NotificationDetailPage extends StatefulWidget {
  final int? id;
  final NotificationModel? item;
  final void Function(NotificationModel)? onChanged;

  const NotificationDetailPage({super.key, this.id, this.item, this.onChanged});

  @override
  State<NotificationDetailPage> createState() => NotificationDetailPageState();
}

class NotificationDetailPageState extends State<NotificationDetailPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  // String title = "";
  NotificationModel? data;
  loadData() async {
    try {
      NotificationModel? _data;
      if (widget.item != null) {
        _data = widget.item;
      } else {
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().notificationbyid(widget.id!);
        if (res.status > 0) {
          _data = NotificationModel.fromJson(res.data);
        }
      }

      setState(() {
        data = _data;
      });
      updateReady(_data!);
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
  }

  updateReady(NotificationModel data) async {
    if (data.status == 2) return;
    try {
      ResponseModel res =
          await DaiLyXeApiBLL_APIUser().notificationready([data.id!]);
      if (res.status > 0) {
        Provider.of<AppProvider>(context, listen: false).minusNotification();
        data.status = 2;
        if (widget.onChanged != null) {
          widget.onChanged!(data);
        }
        if (widget.item != null) {
          setState(() {
            widget.item!.status = 2;
          });
        }
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
  }

  _onDelete() async {
    try {
      ResponseModel res =
          await DaiLyXeApiBLL_APIUser().notificationdelete([data!.id]);
      if (res.status > 0) {
        if (data!.status == 1) {
          Provider.of<AppProvider>(context, listen: false).minusNotification();
        }
        CommonMethods.showToast("success".tr);
        CommonNavigates.toNotificationPage(context);
      } else {
        CommonMethods.showToast(res.message);
      }
      //Call api gọi api xóa
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RxWebView(
      html: """<!DOCTYPE html>
                     <html>
                       <head>
                          <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
                          <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,500;0,700;1,300&display=swap" rel="stylesheet">
                          <style>
                              body{font-family: 'Roboto', sans-serif;}
                          </style>
                       </head>
                       <body style="margin: 0; padding: 10px;">
                          <h3>
                           ${data!.subject}
                         </h3>
                         <div style="margin-bottom: 10px; color: #666">
                           ${data!.rxtimeago}
                         </div>
                         <div>
                           ${data!.message}
                         </div>
                       </body>
                     </html>""",
      title: "detail".tr,
      action: RxIconButton(
          icon: AppIcons.delete,
          onTap: _onDelete,
          size: 40,
          color: Colors.transparent,
          colorIcon: Colors.white),
    );
  }
}
