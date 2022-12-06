// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/utilities/size_config.dart';

Scaffold MMScaffold(
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
    body: SizedBox(
      width: double.infinity,
      height: SizeConfig.screenHeight,
      child: Padding(
          padding: EdgeInsets.only(
              top: top ?? (appBar != null ? CommonConstants.kDefaultPaddingTop : 0)),
          child: child),
    ),
  );
}
