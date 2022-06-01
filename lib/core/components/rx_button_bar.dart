// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class RxButtonBar extends StatelessWidget {
  RxButtonBar(
      {Key? key,
      required this.icon,
      required this.isEnable,
      required this.onPressed})
      : super(key: key);
  Icon icon;
  bool isEnable = false;
  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      color: isEnable ? AppColors.primary : null,
      onPressed: onPressed,
    );
  }
}
