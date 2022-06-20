// ignore_for_file: unrelated_type_equality_checks

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class ItemAdvertWidget extends StatelessWidget {
  final AdvertModel item;

  const ItemAdvertWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: CircleAvatar(
          backgroundColor: AppColors.grayDark, child: RxImage(item.URLIMG)),
      title: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Text(
          item.name,
          style: const TextStyle().bold,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            item.STATUS == 1 ? "active".tr() : "expired".tr(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(color: item.STATUS == 1 ? Colors.green : Colors.red),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Text("${"paymentdeadline".tr()}: ",
                  style: const TextStyle().italic),
              Text(CommonMethods.formatDateTime(CommonMethods.convertToDateTime(item.expirationdate, "dd/MM/yyyy"), valueDefault: "not.update".tr()),
                  style: const TextStyle().bold),
            ],
          ),
        ],
      ),
      isThreeLine: true,
    );
  }
}
