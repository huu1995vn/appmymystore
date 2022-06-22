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
    return RxCard(
      child: GestureDetector(
        onTap: () async {},
        child: SizedBox(
          height: SizeConfig.screenWidth / 4.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(kDefaultPadding),
                    topLeft: Radius.circular(kDefaultPadding)),
                child: RxImage(item.URLIMG, width: SizeConfig.screenWidth / 4),
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
                                    item.STATUS == 1
                                        ? "active".tr()
                                        : "expired".tr(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: item.STATUS == 1
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
                                Text(
                                  item.NUMPRICE,
                                  style: kTextPriceStyle,
                                ),
                                Text(
                                    CommonMethods.formatDateTime(
                                        CommonMethods.convertToDateTime(
                                            item.expirationdate, "dd/MM/yyyy"),
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
