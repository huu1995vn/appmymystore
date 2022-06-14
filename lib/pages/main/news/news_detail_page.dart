// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/constants.dart';

class NewsDetailPage extends StatefulWidget {
  final int id;
  const NewsDetailPage({super.key, required this.id});

  @override
  State<NewsDetailPage> createState() => NewsDetailPageState();
}

class NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  String title = "";
  String detailcontent = "";

  Map<String, dynamic>? data;
  loadData() async {
    ResponseModel res = await DaiLyXeApiBLL_Page().newsdetail(widget.id);
    setState(() {
      data = res.data;
      title = data!["name"];
      detailcontent = data!["detailcontent"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
      appBar: AppBar(
        title: Text(title,
            style: TextStyle(
              color: kWhite,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: RxWrapper(
        body: Text(detailcontent),
      ),
    );
  }
}
