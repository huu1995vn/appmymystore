import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
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
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
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
                                  style: kTextSubTitleStyle.copyWith(
                                      fontStyle: FontStyle.normal,
                                      color: AppColors.black),
                                  //     .bold,
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
                                    item.name ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        // fontSize: 36,
                                        ),
                                  ),
                                  Text(
                                    item.rxprice,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                    ).bold,
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
                                Text(item.rxtimeago, style: kTextTimeStyle),
                                Text(
                                  item.cityname ?? "NaN",
                                  style: kTextSubTitleStyle,
                                ),
                                if (item.userid != APITokenService.userId)
                                  RxIconButton(
                                    icon: AppIcons.heart_1,
                                    onTap: onFavorite,
                                    colorIcon: item.isfavorite
                                        ? AppColors.primary
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
      ),
    );
  }
}
