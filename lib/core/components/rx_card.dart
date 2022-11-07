import 'package:flutter/material.dart';
import 'package:mymystore/core/utilities/constants.dart';

class RxCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final RoundedRectangleBorder? shape;
  final bool isBorder;
  const RxCard(
      {key, required this.child, this.margin, this.shape, this.isBorder = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: isBorder
          ? (shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultPadding),
              ))
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
      elevation: 0,
      // margin: margin ?? const EdgeInsets.only(bottom: 20),
      child: child,
    );
  }
}
