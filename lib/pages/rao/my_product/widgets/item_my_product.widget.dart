import 'dart:math';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemMyProductWidget extends StatelessWidget {
 final ProductModel itemProduct;
  final void Function()? onTap;
  const ItemMyProductWidget(this.itemProduct, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    int lenimg = Random().nextInt(15); //itemProduct.rximglist.length

    return Card(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: SizeConfig.screenWidth / 4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(kDefaultPadding),
                      topLeft: Radius.circular(kDefaultPadding)),
                  child: Stack(
                    children: <Widget>[
                      RxImage(itemProduct.rximg,
                          width: SizeConfig.screenWidth / 4),
                      if (lenimg > 0)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: AppColors.white50),
                              color: AppColors.black50,
                            ),
                            child: SizedBox(
                                height: 15, width: 20, child: Container()),
                          ),
                        ),
                      if (lenimg > 0)
                        Positioned(
                          top: 3,
                          right: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: AppColors.white50),
                              color: AppColors.black,
                            ),
                            child: SizedBox(
                                height: 15,
                                width: 20,
                                child: Center(
                                    child: Text(
                                  lenimg >= 9 ? "9+" : lenimg.toString(),
                                  style: const TextStyle(color: AppColors.white)
                                      .bold
                                      .size(12),
                                ))),
                          ),
                        ),
                    ],
                  )),
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
                                    itemProduct.name ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        // fontSize: 36,
                                        ),
                                  ),
                                  Text(
                                    CommonMethods.formatNumber(itemProduct.price ?? "4000000"),
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                    ).bold,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              // spacing: kDefaultPadding,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  itemProduct.cityname ?? "Tp.HCM",
                                  style: const TextStyle(
                                    color: AppColors.black50,
                                  ).bold.size(12),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.brightness_low_outlined,
                                      color: AppColors.yellow,
                                      size: 19,
                                    ),
                                    Text("Tin ưu tiên",
                                        style: const TextStyle(
                                          color: AppColors.yellow,
                                        ).bold.size(10)),
                                  ],
                                ),
                                
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
