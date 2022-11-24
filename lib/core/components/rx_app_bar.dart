// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

AppBar MMAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    elevation: 0,
    title: title,
    actions: actions,
    automaticallyImplyLeading: false, // this should be false :)
    titleSpacing: 0,
    leading: leading,
  );
}
