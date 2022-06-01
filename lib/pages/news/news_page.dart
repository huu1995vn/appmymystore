// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        RxScaffold(
            appBar: AppBar(
              title: Text('news.text'.tr()),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            child: 
              RxWrapper(
                  body: Text("News"),
                ),
            );
  }
}
