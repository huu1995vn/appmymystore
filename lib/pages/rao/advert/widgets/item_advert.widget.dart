// ignore_for_file: unrelated_type_equality_checks

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
// ignore: unused_import
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemAdvertWidget extends StatelessWidget {
  final AdvertModel item;

  const ItemAdvertWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: kDefaultPadding, bottom: kDefaultPadding),
        child: GestureDetector(
            onTap: () async {},
            child: SizedBox(
              height: SizeConfig.screenWidth / 6,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child:
                        RxImage(item.URLIMG, width: SizeConfig.screenWidth / 6),
                  ),
                  const SizedBox(width: kDefaultPadding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                               style: const TextStyle(color: AppColors.primary).bold,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            // Text("${"paymentdeadline".tr()}: ",
                            //     style: const TextStyle().italic),
                            Expanded(
                                child: Text(
                                    CommonMethods.formatDateTime(
                                        CommonMethods.convertToDateTime(
                                            item.expirationdate, "dd/MM/yyyy"),
                                        valueDefault: "not.update".tr()),
                                    style: const TextStyle().italic)),
                            Text(
                              item.STATUS == 1 ? "active".tr() : "expired".tr(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: item.STATUS == 1
                                      ? Colors.green
                                      : Colors.red),
                            ),
                            SizedBox(width: 10,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
