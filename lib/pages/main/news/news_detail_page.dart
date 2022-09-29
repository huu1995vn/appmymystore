// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';

class NewsDetailPage extends StatefulWidget {
  final int? id;
  final NewsModel? item;
  const NewsDetailPage({super.key, this.id, this.item});

  @override
  State<NewsDetailPage> createState() => NewsDetailPageState();
}

class NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  // String title = "";
  String? initialUrl;
  Map<String, dynamic>? data;
  loadData() async {
    if (widget.item != null) {
      setState(() {
        initialUrl = widget.item!.rxlink;
      });
    } else {
      ResponseModel res = await DaiLyXeApiBLL_APIGets().newsbyid(widget.id!);
      data = res.data;
      String prefixUrl = data!["prefix"];
      String rewriteUrl = data!["url"];
      setState(() {
        initialUrl = CommonMethods.buildUrlNews(int.parse(data!["id"]),
            prefixUrl: prefixUrl, rewriteUrl: rewriteUrl);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RxWebView(
      url: initialUrl,
      javaScriptString:
          '''document.querySelectorAll("section.header, section.get-info, section.footer-info, .breadcrumb, .navbar-custom, .navbar-bottom").forEach(e => e.remove());''',
      title: "news".tr,
    );
  }
}
