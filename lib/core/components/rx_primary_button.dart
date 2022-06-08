import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/constants.dart';

class RxPrimaryButton extends StatelessWidget {
  const RxPrimaryButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: kBoxDecorationStyle.copyWith(
            borderRadius: BorderRadius.circular(50)),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: kWhite,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
