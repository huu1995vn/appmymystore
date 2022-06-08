import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemChild extends StatelessWidget {
  final String label;
  final Widget? child;
  final String value;
  final IconButton? iconButton;
  final BorderSide? bottom;
  const ItemChild(this.label,
      {Key? key, this.child, required this.value, this.iconButton, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle().bold,
          ),
          Container(
            child: child ??
                Row(
                  children: <Widget>[
                    Container(
                        width: SizeConfig.screenWidth - 160,
                        alignment: Alignment.centerRight,
                        child: Text(
                          value ?? "",
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.end,
                          maxLines: 2,
                        )),
                  ],
                ),
          )
        ],
      ),
    );
  }
}
