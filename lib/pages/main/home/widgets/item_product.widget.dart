import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemProductWidget extends StatelessWidget {
  final ProductModel item;
  final void Function()? onTap;
  final void Function()? onFavorite;
  const ItemProductWidget(this.item, {super.key, this.onTap, this.onFavorite});
  @override
  Widget build(BuildContext context) {
    int lenimg = item.rximglist.length;
    bool isDark = Get.isDarkMode;
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: SizedBox(
        height: SizeConfig.screenWidth / 4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: onTap,
                  child: RxImage(item.rximg, width: SizeConfig.screenWidth / 4),
                ),
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
                      child:
                          SizedBox(height: 15, width: 20, child: Container()),
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
                            style: kTextSubTitleStyle.copyWith(
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                color: AppColors.black),
                            //     .bold,
                          ))),
                    ),
                  ),
              ],
            ),
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
                                GestureDetector(
                                  onTap: onTap,
                                  child: Text(
                                    item.name ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      CommonMethods.formatShortCurrency(
                                          item.price),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColors.primary,
                                      ).bold,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: item!.state == 1
                                              ? Colors.blue
                                              : Colors.yellow,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        child: Text(item!.statename,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: item!.state == 1
                                                    ? Colors.white
                                                    : Colors.black)))
                                  ],
                                ),
                                if (item.status > 2 && item.reject != null)
                                  Text(
                                    item.reject!,
                                    style: kTextSubTitleStyle.copyWith(
                                        color: AppColors.danger),
                                  ),
                              ],
                            ),
                          ),
                          Row(
                            // spacing: kDefaultPadding,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(item.rxtimeago,
                                      style: kTextTimeStyle.copyWith(
                                          color: isDark
                                              ? Colors.white54
                                              : Colors.grey)),
                                  SizedBox(width: 7),
                                  Container(
                                    width: 3,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    item.cityname ?? "NaN",
                                    style: kTextSubTitleStyle.copyWith(
                                        color: isDark
                                            ? Colors.white54
                                            : Colors.grey),
                                  ),
                                ],
                              ),
                              if (item.userid != APITokenService.userId)
                                RxIconButton(
                                  icon: item.isfavorite
                                      ? FontAwesomeIcons.solidBookmark
                                      : FontAwesomeIcons.bookmark,
                                  onTap: onFavorite,
                                  size: 35,
                                  colorIcon: item.isfavorite
                                      ? AppColors.yellow
                                      : AppColors.secondary,
                                )
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
    );
  }
}
