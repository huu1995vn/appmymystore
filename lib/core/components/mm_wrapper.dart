import 'package:flutter/material.dart';

class MMWrapper extends StatelessWidget {
  const MMWrapper({
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
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: body,
        ),
      ),
    );
  }
}
