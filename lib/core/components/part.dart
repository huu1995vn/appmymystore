import 'package:flutter/material.dart';

Widget RxDivider({double indent = 20}) {
  return Divider(
      thickness: 1, // thickness of the line
      indent: indent ?? 20,
      endIndent: indent ?? 20,
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
          child: child,
          duration: const Duration(milliseconds: 500),
        ));
  }
}
