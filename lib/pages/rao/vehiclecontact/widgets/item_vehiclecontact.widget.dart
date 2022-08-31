// ignore_for_file: unrelated_type_equality_checks

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
// ignore: unused_import
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemVehicleContactWidget extends StatelessWidget {
  final VehicleContactModel item;

  const ItemVehicleContactWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return RxCard(
      child: GestureDetector(
        onTap: () async {},
        child: SizedBox(
          height: SizeConfig.screenWidth / 4.3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(kDefaultPadding),
                    topLeft: Radius.circular(kDefaultPadding)),
                child: Icon(AppIcons.email, color: AppColors.grey, size: 30),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Stack(
                      children: [
                        Column(
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
                                  ),
                                  Text(
                                    item.status == 1
                                        ? "active".tr()
                                        : "expired".tr(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: item.status == 1
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              // spacing: kDefaultPadding,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   item.rxprice,
                                //   style: kTextPriceStyle,
                                // ),
                                Text(
                                    CommonMethods.formatDateTime(
                                        item.createdate,
                                        valueDefault: "not.update".tr()),
                                    style: kTextTimeStyle)
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
