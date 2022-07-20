// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
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
    NotificationModel? _data;

    if (widget.item != null) {
      setState(() {
        _data = widget.item;
      });
    } else {
      ResponseModel res = await DaiLyXeApiBLL_APIGets().newsbyid(widget.id!);
      if (res.status > 0) {
        _data = NotificationModel.fromJson(res.data);
      } else {
        _data = null!;
      }
    }
    setState(() {
      data = _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RxWebView(
      html: data!.message,
      title: data!.subject,
    );
  }
}
