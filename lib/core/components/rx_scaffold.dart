// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mymystore/core/utilities/constants.dart';
import 'package:mymystore/core/utilities/size_config.dart';

Scaffold RxScaffold(
    {Key? key,
    PreferredSizeWidget? appBar,
    Widget? child,
    double? top,
    Color? color,
    Decoration? decoration}) {
  return Scaffold(
    key: key,
    appBar: appBar,
    backgroundColor: color ?? Colors.white,
    extendBodyBehindAppBar: true,
    body: Container(
      width: double.infinity,
      height: SizeConfig.screenHeight,
      child: Padding(
          padding: EdgeInsets.only(
              top: top ?? (appBar != null ? kDefaultPaddingTop : 0)),
          child: child),
    ),
  );
}
