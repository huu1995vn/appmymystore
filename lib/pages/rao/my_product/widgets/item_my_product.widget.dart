import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemMyProductWidget extends StatelessWidget {
  final ProductModel item;

  const ItemMyProductWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: kDefaultPadding, bottom: kDefaultPadding),
        child: GestureDetector(
          onTap: () async {},
          child: SizedBox(
            height: SizeConfig.screenWidth / 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: <Widget>[
                        RxImage(item.URLIMG, width: SizeConfig.screenWidth / 4),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: AppColors.grayDark,
                              shape: CircleBorder(),
                            ),
                            child: Text(
                              item.LISTURLIMG.length.toString(),
                              style: const TextStyle().bold,
                            ),
                          ),
                        )
                      ],
                    )),
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
                              style: const TextStyle(
                                  // fontSize: 36,
                                  ),
                            ),
                            Text(
                              item.NUMPRICE,
                              style: const TextStyle(
                                color: AppColors.primary,
                              ).bold,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                                  CommonMethods.formatDateTime(
                                      CommonMethods.convertToDateTime(
                                          item.createdate, "dd/MM/yyyy"),
                                      valueDefault: "not.update".tr()),
                                  style: const TextStyle().italic)),
                          if (item.STATUS == 2)
                            GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.upload,
                                  color: AppColors.yellow,
                                ))
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: const Icon(
                          //       Icons.upload,
                          //       color: AppColors.yellow,
                          //     ),
                          //     iconSize: 13
                          //     )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
