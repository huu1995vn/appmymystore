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
  final void Function()? onTap;
  const ItemMyProductWidget(this.item, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    int lenimg = item.rximglist.length;

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
                      RxImage(item.rximg, width: SizeConfig.screenWidth / 4),
                      if (lenimg > 0)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: AppColors.black50),
                              color: AppColors.grey,
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
                              border: Border.all(color: AppColors.black50),
                              color: AppColors.grey,
                            ),
                            child: SizedBox(
                                height: 15,
                                width: 20,
                                child: Center(
                                    child: Text(
                                  lenimg >= 9 ? "9+" : lenimg.toString(),
                                  style: kTextSubTitleStyle.copyWith(fontStyle: FontStyle.normal),
                                ))),
                          ),
                        ),
                    ],
                  )),
              Expanded(
                child: Padding(
                    padding: kEdgeInsetsPadding,
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
                                    item.name ?? "NaN",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    CommonMethods.formatNumber(
                                        item.price ?? "NaN"),
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
                                  item.cityname ?? "NaN",
                                  style: kTextSubTitleStyle,
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
