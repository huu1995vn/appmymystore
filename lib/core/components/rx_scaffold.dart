// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';

Scaffold RxScaffold({PreferredSizeWidget? appBar, Widget? child, double? top}) {
  return Scaffold(
    appBar: appBar,
    extendBodyBehindAppBar: true,
    body: Container(
      decoration: kBoxDecorationStyle,
      width: double.infinity,
      height: SizeConfig.screenHeight,
      child: Padding(
          padding: EdgeInsets.only(
              top: top ?? (appBar != null ? kDefaultPaddingTop : 0)),
          child: child),
    ),
  );
}
