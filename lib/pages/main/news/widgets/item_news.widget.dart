// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemNewsWidget extends StatelessWidget {
  final NewsModel itemNews;
  void Function()? onTap;
  ItemNewsWidget(this.itemNews, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RxCard(
        child: GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: SizeConfig.screenWidth / 4.5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(kDefaultPadding),
                  topLeft: Radius.circular(kDefaultPadding)),
              child:
                  RxImage(itemNews.URLIMG, width: SizeConfig.screenWidth / 4.5),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        itemNews.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(),
                      ),
                    ),
                    Row(
                      // spacing: kDefaultPadding,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          itemNews.webresourcename,
                          style: const TextStyle(
                            color: AppColors.yellow,
                          ).italic,
                        ),
                        Text(itemNews.TIMEAGO,
                            style: kTextTimeStyle),
                        // Text(itemNews.views,
                        //     style: const TextStyle(
                        //         color: AppColors.black50,
                        //         fontStyle: FontStyle.italic))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
