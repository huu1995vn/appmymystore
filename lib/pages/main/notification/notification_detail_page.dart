// ignore_for_file: prefer_const_constructors, empty_catches, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/notification_provider.dart';

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
        Provider.of<NotificationProvider>(context, listen: false)
            .readeNotification();
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

  @override
  Widget build(BuildContext context) {
    return RxWebView(
      html: data!.message,
      title: data!.subject,
    );
  }
}
