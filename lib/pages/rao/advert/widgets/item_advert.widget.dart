// ignore_for_file: unrelated_type_equality_checks

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
// ignore: unused_import
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemAdvertWidget extends StatelessWidget {
  final AdvertModel item;

  const ItemAdvertWidget(this.item, {super.key});

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
          child: GestureDetector(
            onTap: () async {},
            child: SizedBox(
              height: SizeConfig.screenWidth / 4.3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child:
                        RxImage(item.rximg, width: SizeConfig.screenWidth / 4),
                  ),
                  Expanded(
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: kDefaultPaddingBox),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        item.status == 1
                                            ? "active".tr
                                            : "expired".tr,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.rxprice,
                                      style: kTextPriceStyle,
                                    ),
                                    Text(
                                        CommonMethods.formatDateTime(
                                            item.expirationdate,
                                            valueDefault: "not.update".tr),
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
          )),
    );
  }
}
