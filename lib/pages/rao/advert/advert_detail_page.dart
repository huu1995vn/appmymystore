// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/theme_provider.dart';
import 'package:raoxe/core/utilities/constants.dart';

class AdvertDetailPage extends StatefulWidget {
  final int? id;
  final AdvertModel? item;

  const AdvertDetailPage({super.key, this.id, this.item});

  @override
  State<AdvertDetailPage> createState() => _AdvertDetailPageState();
}

class _AdvertDetailPageState extends State<AdvertDetailPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  AdvertModel? data;
  loadData() async {
    try {
      if (widget.item != null) {
        setState(() {
          data = widget.item;
        });
      } else {
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().advertbyid(widget.id!);
        if (res.status > 0) {
          List<dynamic> ldata = jsonDecode(res.data);
          setState(() {
            data = AdvertModel.fromJson(ldata[0]);
          });
        } else {
          CommonMethods.showToast(res.message);
        }
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết quảng cáo',
          style: kTextHeaderStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: RxWrapper(
        body: Column(
          children: [Text("advert-detail ${widget.item!.name}")],
        ),
      ),
    );
  }
}
