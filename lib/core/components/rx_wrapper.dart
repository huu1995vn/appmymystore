import 'package:flutter/material.dart';

class RxWrapper extends StatelessWidget {
  const RxWrapper({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        // alignment: Alignment.topCenter,
        child: body,
      ),
    );
  }
}
