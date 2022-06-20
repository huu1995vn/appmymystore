// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class ItemContactWidget extends StatelessWidget {
  final ContactModel item;

  const ItemContactWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.fullname,
        overflow: TextOverflow.ellipsis,
        // style: TextStyle(FontWeight.normal),
      ),
      leading: const CircleAvatar(
          backgroundColor: AppColors.grayDark,
          child:
              Icon(Icons.local_airport_rounded, color: AppColors.primary800, size: 30)),
      subtitle: Text(item.address),
      isThreeLine: true,
      onTap: () {
        // onSelected(context, index);
      },
    );
  }
}
