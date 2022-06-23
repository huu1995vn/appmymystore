// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';

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
      body: Column(children: [
        Expanded(
          child: Center(
            child: Text(widget.message,
                style: const TextStyle(color: AppColors.primary)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: RxPrimaryButton(
              text: "Ok",
              onTap: () {
                CommonNavigates.exit(context);
              }),
        ),
      ]),
    );
  }
}
