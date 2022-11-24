// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/commons/flutter_app_version_checker.dart';
import 'package:mymystore/core/components/part.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/utilities/constants.dart';
import 'package:mymystore/core/utilities/extensions.dart';

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ("${"newversion".tr}!").toUpperCase(),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                "pattern.str001".tr.format([widget.data.newVersion!]),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Image.asset(
                  LOGO,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: MMButton(
                      text: "update".tr,
                      onTap: () {
                        CommonMethods.launchURL(widget.data.appURL!);
                      },
                      color: AppColors.blue,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: MMButton(
                    text: "exit".tr,
                    onTap: () {
                      CommonNavigates.exitApp(context);
                    },
                    color: Colors.blueGrey,
                  ))
                ],
              ),
            ],
          ),
        ));
  }
}
