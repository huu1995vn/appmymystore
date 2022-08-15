// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class RxIconButton extends StatelessWidget {
  RxIconButton(
      {Key? key,
      required this.icon,
      this.onTap,
      this.size = 30,
      this.colorIcon = AppColors.secondary})
      : super(key: key);
  bool isEnable = false;
  GestureTapCallback? onTap;
  IconData icon;
  double size;
  Color colorIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTap: onTap,
              child: 
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    // border: Border.all(color: AppColors.secondary.withOpacity(0.01)),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.secondary.withOpacity(0.15),
                          blurRadius: 5,
                          offset: const Offset(0, 5))
                    ]),
                child: Center(
                  child: Icon(
                    icon,
                    size: size/2,
                    color: colorIcon,
                  ),
                ),
              )
              
              );
  }
}
