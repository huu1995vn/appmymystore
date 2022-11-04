// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';

class RxButtonBar extends StatelessWidget {
  RxButtonBar(
      {Key? key,
      required this.icon,
      required this.isEnable,
      required this.onTap,
      this.onDoubleTap,
      })
      : super(key: key);
  Widget icon;
  bool isEnable = false;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: onDoubleTap,
        // onTap: onTap,
        child: IconButton(
          icon: icon,
          color: isEnable
              ? Theme.of(context).primaryColor
              : Theme.of(context).hintColor,
          onPressed: onTap )
        );
  }
}
