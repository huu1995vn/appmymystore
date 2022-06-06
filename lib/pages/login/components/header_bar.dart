import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import '../../../core/utilities/constants.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          Image.asset(
            LOGORAOXEWHITEIMAGE,
            width: 150,
          ),
          const Text(
            'Welcome to back',
            style: TextStyle(
              color: AppColors.white,
              // fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
