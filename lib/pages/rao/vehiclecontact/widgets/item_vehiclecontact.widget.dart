// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/entities.dart';
// ignore: unused_import
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemVehicleContactWidget extends StatelessWidget {
  final VehicleContactModel item;
  final void Function()? onTap;
  const ItemVehicleContactWidget(this.item, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.all(kDefaultPaddingBox),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: CircleAvatar(
                  child: Icon(AppIcons.email,
                      color:
                          item.status == 1 ? AppColors.yellow : AppColors.grey,
                      size: 30)),
              title: Text(item.subject!,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              subtitle: Transform.translate(
                offset: const Offset(0, 10),
                child: Text(item.message!, maxLines: 2),
              ),
              // trailing: Icon(Icons.keyboard_arrow_right),
              isThreeLine: true,
              onTap: onTap,
            )));
  }
}
