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
    return Padding(
      padding:
          const EdgeInsets.only(top: kDefaultPadding, bottom: kDefaultPadding),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: SizeConfig.screenWidth / 4.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: RxImage(itemNews.URLIMG,
                      width: SizeConfig.screenWidth / 4),
                ),
              ),
              Expanded(
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
                    Text(
                      itemNews.webresourcename,
                      style: const TextStyle(
                        color: AppColors.yellow,
                      ).italic,
                    ),
                    Wrap(
                      spacing: kDefaultPadding,
                      children: [
                        Text(itemNews.TIMEAGO,
                            style: const TextStyle(
                                color: AppColors.black50,
                                fontStyle: FontStyle.italic)),
                        Text(itemNews.views,
                            style: const TextStyle(
                                color: AppColors.black50,
                                fontStyle: FontStyle.italic))
                      ],
                    )
                    // Text.rich(

                    //   TextSpan(
                    //     children: <TextSpan>[
                    //       // TextSpan(
                    //       //     text: "${itemNews.webresourcename}",
                    //       //     style: const TextStyle(
                    //       //         fontStyle: FontStyle.italic,
                    //       //         color: AppColors.yellow)),
                    //       TextSpan(
                    //           text: "${itemNews.TIMEAGO} . ",
                    //           style:
                    //               const TextStyle(fontStyle: FontStyle.italic)),
                    //       TextSpan(
                    //         text: "${itemNews.views}",
                    //         style: const TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     ],
                    //     style: const TextStyle(
                    //       color: AppColors.black50,
                    //       fontSize: 13,
                    //     ).italic.light,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
