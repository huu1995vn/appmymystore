// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget RxDivider({double indent = 20}) {
  return Divider(
      thickness: 1, // thickness of the line
      indent: indent,
      endIndent: indent,
      height: 1);
}

Widget RxBuildItem(
    {required String title,
    Widget? icon,
    void Function()? onTap,
    Widget? trailing}) {
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

class RxDisabled extends StatelessWidget {
  final Widget child;
  final bool? lock;
  final bool disabled;

  const RxDisabled(
      {Key? key, this.disabled = false, required this.child, this.lock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? _lock = lock;
    if (disabled && lock == null) {
      _lock = true;
    }
    return AbsorbPointer(
        absorbing: _lock ?? false,
        child: AnimatedOpacity(
            opacity: disabled ? 0.5 : 1,
            duration: const Duration(milliseconds: 500),
            child: child));
  }
}
