// ignore_for_file: prefer_const_constructors, empty_catches

import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';

class NotificationDetailPage extends StatefulWidget {
  final int? id;
  final NotificationModel? item;
  const NotificationDetailPage({super.key, this.id, this.item});

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
      setState(() {
        _data = widget.item;
      });
    } else {
      ResponseModel res = await DaiLyXeApiBLL_APIUser().notificationbyid(widget.id!);
      if (res.status > 0) {
        _data = NotificationModel.fromJson(res.data);
      } else {
        _data = null!;
      }
    }
    setState(() {
      data = _data;
    });
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
    
  }
  updateReady()
  async {
    try {
      ResponseModel res = await DaiLyXeApiBLL_APIUser().notificationready([widget.id!]);
      if (res.status > 0) {
        widget.item!.status = 2;
      } 
    } catch (e) {
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
