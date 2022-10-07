import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

import '../../../../core/components/part.dart';

class ItemProductWidget extends StatefulWidget {
  final ProductModel item;
  final ViewType? viewType;
  final void Function()? onTap;
  const ItemProductWidget(this.item, {super.key, this.onTap, this.viewType});

  @override
  State<ItemProductWidget> createState() => _ItemProductWidgetState();
}

class _ItemProductWidgetState extends State<ItemProductWidget> {
  onFavorite() async {
    // ProductModel item = listData![index];
    try {
      var res = await CommonMethods.onFavorite(
          context, [widget.item.id], !widget.item.isfavorite);

      if (res) {
        setState(() {});
        CommonMethods.showToast("success".tr);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    int lenimg = widget.item.rximglist.length;
    bool isDark = Get.isDarkMode;
    return (widget.viewType == ViewType.grid)
        ? Card(
            child: Container(
              padding: const EdgeInsets.all(kDefaultPaddingBox),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap: widget.onTap,
                        child: SizedBox(
                            height: SizeConfig.screenWidth / 3.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: RxImage(
                                widget.item.rximg,
                              ),
                            )),
                      ),
                      if (lenimg > 0)
                        Positioned(
                          top: 5,
                          left: 5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: AppColors.grey.withOpacity(0.5),
                                  width: 1.0),
                            ),
                            child: SizedBox(
                                height: 15, width: 20, child: Container()),
                          ),
                        ),
                      if (lenimg > 0)
                        Positioned(
                          top: 3,
                          left: 3,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: AppColors.grey.withOpacity(0.5),
                                  width: 1.0),
                            ),
                            child: SizedBox(
                                height: 15,
                                width: 20,
                                child: Center(
                                    child: Text(
                                  lenimg >= 9 ? "9+" : lenimg.toString(),
                                  style: kTextSubTitleStyle.copyWith(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12),
                                  //     .bold,
                                ))),
                          ),
                        ),
                      Positioned(
                          bottom: 3,
                          right: 3,
                          child: (widget.item.userid != APITokenService.userId)
                              ? RxIconButton(
                                  icon: widget.item.isfavorite
                                      ? FontAwesomeIcons.solidBookmark
                                      : FontAwesomeIcons.bookmark,
                                  onTap: onFavorite,
                                  size: 30,
                                  color: Colors.white,
                                  colorIcon: widget.item.isfavorite
                                      ? AppColors.yellow
                                      : AppColors.black50,
                                )
                              : Container()),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                                      GestureDetector(
                                        onTap: widget.onTap,
                                        child: Text(
                                          widget.item.name ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            CommonMethods.formatShortCurrency(
                                                widget.item.price),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: AppColors.primary,
                                            ).bold,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: widget.item!.state == 1
                                                    ? Colors.blue
                                                    : Colors.yellow,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 2),
                                              child: Text(
                                                  widget.item!.statename,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          widget.item!.state ==
                                                                  1
                                                              ? Colors.white
                                                              : Colors.black)))
                                        ],
                                      ),
                                      if (widget.item.status > 2 &&
                                          widget.item.reject != null)
                                        Text(
                                          widget.item.reject!,
                                          style: kTextSubTitleStyle.copyWith(
                                              color: AppColors.danger),
                                        ),
                                    ],
                                  ),
                                ),
                                Row(
                                  // spacing: kDefaultPadding,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            CommonNavigates.toUserPage(context,
                                                id: widget.item.userid);
                                          },
                                          child: RxAvatarImage(
                                              widget.item.rximguser,
                                              size: 25),
                                        ),
                                        const SizedBox(width: 3),
                                        Container(
                                          width: 3,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          widget.item.rxtimeago,
                                          style: kTextTimeStyle.copyWith(
                                              fontSize: 10),
                                        ),
                                        const SizedBox(width: 3),
                                        Container(
                                          width: 3,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 7),
                                        Text(
                                          widget.item.cityname ?? "NaN",
                                          style: kTextSubTitleStyle.copyWith(
                                              fontSize: 10),
                                        ),
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
          )
        : Card(
            margin: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.all(kDefaultPaddingBox),
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
                            onTap: widget.onTap,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: RxImage(
                                widget.item.rximg,
                                width: 100,
                                height: 100,
                              ),
                            )),
                        if (lenimg > 0)
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: AppColors.grey.withOpacity(0.5),
                                    width: 1.0),
                              ),
                              child: SizedBox(
                                  height: 15, width: 20, child: Container()),
                            ),
                          ),
                        if (lenimg > 0)
                          Positioned(
                            top: 3,
                            right: 3,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: AppColors.grey.withOpacity(0.5),
                                    width: 1.0),
                              ),
                              child: SizedBox(
                                  height: 15,
                                  width: 20,
                                  child: Center(
                                      child: Text(
                                    lenimg >= 9 ? "9+" : lenimg.toString(),
                                    style: kTextSubTitleStyle.copyWith(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12),
                                    //     .bold,
                                  ))),
                            ),
                          ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
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
                                        GestureDetector(
                                          onTap: widget.onTap,
                                          child: Text(
                                            widget.item.name ?? "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              CommonMethods.formatShortCurrency(
                                                  widget.item.price),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: AppColors.primary,
                                              ).bold,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: widget.item!.state == 1
                                                      ? Colors.blue
                                                      : Colors.yellow,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                child: Text(
                                                    widget.item!.statename,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: widget.item!
                                                                    .state ==
                                                                1
                                                            ? Colors.white
                                                            : Colors.black)))
                                          ],
                                        ),
                                        if (widget.item.status > 2 &&
                                            widget.item.reject != null)
                                          Text(
                                            widget.item.reject!,
                                            style: kTextSubTitleStyle.copyWith(
                                                color: AppColors.danger),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    // spacing: kDefaultPadding,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              CommonNavigates.toUserPage(
                                                  context,
                                                  id: widget.item.userid);
                                            },
                                            child: RxAvatarImage(
                                                widget.item.rximguser,
                                                size: 25),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: 3,
                                            height: 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(widget.item.rxtimeago,
                                              style: kTextTimeStyle.copyWith(
                                                  fontSize: 12)),
                                          const SizedBox(width: 5),
                                          Container(
                                            width: 3,
                                            height: 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            widget.item.cityname ?? "NaN",
                                            style: kTextSubTitleStyle.copyWith(
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      if (widget.item.userid !=
                                          APITokenService.userId)
                                        RxIconButton(
                                          icon: widget.item.isfavorite
                                              ? FontAwesomeIcons.solidBookmark
                                              : FontAwesomeIcons.bookmark,
                                          onTap: onFavorite,
                                          size: 35,
                                          color: Colors.transparent,
                                          colorIcon: widget.item.isfavorite
                                              ? AppColors.yellow
                                              : (Get.isDarkMode
                                                  ? Colors.white
                                                  : AppColors.black50),
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
            ));
  }
}
