// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/utilities/constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return RxScaffold(
      appBar: AppBar(
        title: Text('login'.tr(),
            style: TextStyle(
              color: kWhite,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: RxWrapper(
        body: Text("login"),
      ),
    );
  }
}
