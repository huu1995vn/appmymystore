// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class RxIconButton extends StatelessWidget {
  RxIconButton(
      {Key? key,
      required this.icon,
      this.onTap,
      this.size = 30,
      this.color = AppColors.white,
      this.colorIcon})
      : super(key: key);
  bool isEnable = false;
  GestureTapCallback? onTap;
  IconData icon;
  double size;
  Color color;
  Color? colorIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              size: size / 2,
              color: colorIcon,
            ),
          ),
        ));
  }
}
