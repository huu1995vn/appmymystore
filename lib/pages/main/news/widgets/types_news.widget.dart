import 'package:flutter/material.dart';
import 'package:raoxe/core/components/rx_rounded_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';

class TypesNewsWidget extends StatelessWidget {
  final int itemselect;
  final void Function(int v) onPressed;
  const TypesNewsWidget(this.itemselect, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Categorie item = CATEGORIES[index];
            return Padding(
              padding: const EdgeInsets.only(right: 5),
              child: RxRoundedButton(
                  radius: 5,
                  title: item.categoryname,
                  onPressed: () {
                    if (itemselect != item.id) {
                      onPressed(item.id);
                    }
                  },
                  color: itemselect != item.id ? AppColors.black50 : null),
            );
          },
          itemCount: CATEGORIES.length),
    );
  }
}
