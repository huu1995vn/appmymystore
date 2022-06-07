// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/utilities/constants.dart';

class NewsDetailPage extends StatefulWidget {
  final int id;
  const NewsDetailPage({super.key, required this.id});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return
        RxScaffold(
            appBar: AppBar(
              title: Text('news.text'.tr(), style: TextStyle(
            color: kWhite,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          )),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            child: 
              RxWrapper(
                  body: Text("News-detail-${widget.id}"),
                ),
            );
  }
}
