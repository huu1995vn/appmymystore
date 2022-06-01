import 'package:flutter/material.dart';

Widget RxDivider({double indent = 20}) {
  return Divider(
      thickness: 1, // thickness of the line
      indent: indent ?? 20,
      endIndent: indent ?? 20,
      height: 1);
}

Widget RxBuildItem(
      { required String title, Widget? icon, void Function()? onTap, Widget? trailing}) {
    return Column(children: [
      ListTile(
        leading: icon,
        title: Text(title),
        trailing: trailing,
        onTap: onTap,
      ),
      RxDivider(),
    ]);
  }