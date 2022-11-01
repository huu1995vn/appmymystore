// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key, required this.data});
  final AppCheckerResult data;
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(),
          Text("pattern.str001"
              .tr
              .format([widget.data.currentVersion, widget.data.newVersion!])),
          Positioned(
            bottom: 100,
            left: 30,
            child: RxButton(
              text: "exit".tr,
              onTap: () {
                CommonNavigates.exit(context);
              },
              color: AppColors.black50,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 30,
            child: RxButton(
              text: "update".tr,
              onTap: () {
                CommonMethods.launchURL(widget.data.appURL!);
              },
              color: AppColors.blue,
            ),
          )
        ],
      ),
    );
  }
}
