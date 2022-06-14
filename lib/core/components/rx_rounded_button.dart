import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class RxRoundedButton extends StatelessWidget {
  const RxRoundedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.color,
  }) : super(key: key);

  final GestureTapCallback onPressed;
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        side: BorderSide(width: 2.0, color: color?? AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: Text(title, style: TextStyle(color: color?? AppColors.primary),),
    );
  }
}
