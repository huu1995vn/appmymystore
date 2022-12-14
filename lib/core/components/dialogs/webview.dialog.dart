// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/components/mm_part.dart';

class HtmlViewDialog extends StatefulWidget {
  String? url;
  String? title;
  Widget? action;
  String? javaScriptString;
  String? html;
  HtmlViewDialog(
      {super.key,
      this.url,
      this.title,
      this.action,
      this.javaScriptString,
      this.html});
  @override
  HtmlViewDialogState createState() => HtmlViewDialogState();
}

class HtmlViewDialogState extends State<HtmlViewDialog> {
  final _key = UniqueKey();
  bool isLoading = true;
  late InAppWebViewController _controller;
  @override
  void initState() {
    super.initState();
  }

  Size get screenSize => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: MMText(data: widget.title ?? "content".tr),
          elevation: 0.0,
          actions: [widget.action!],
        ),
        body: MMHtmlView(url: widget.url, html: widget.html));
  }
}
