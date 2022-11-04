// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:get/get.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/part.dart'; 
import '../../app_icons.dart'; 

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key, required this.message});
  final String message;
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
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
              SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ("noconnect".tr + "!").toUpperCase(),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "noconnectmessage".tr,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                child: Icon(
                  AppIcons.signal_wifi_off,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  size: 100,
                ),
              ), 
              const SizedBox(height: 70),
              Row(
                children: [
                  Expanded(
                      child: RxButton(
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
