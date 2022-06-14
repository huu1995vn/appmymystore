import 'package:flutter/material.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemNewsWidget extends StatelessWidget {
  final NewsModel itemNews;

  const ItemNewsWidget(this.itemNews, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: kDefaultPadding, bottom: kDefaultPadding),
      child: GestureDetector(
        onTap: () async {},
        child: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child:
                    RxImage(itemNews.urlImg, width: SizeConfig.screenWidth / 4),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        itemNews.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            // fontSize: 36,
                            ),
                      ),
                    ),
                    Text(
                      itemNews.webresourcename,
                      style: const TextStyle(
                        color: AppColors.primary,
                        // fontSize: 28,
                      ).bold,
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "${itemNews.publishdate} | ",
                              style: const TextStyle(fontStyle: FontStyle.italic)),
                          TextSpan(
                              text: "${itemNews.views} lượt xem",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                        style: const TextStyle(
                          color: AppColors.black50,
                          fontSize: 13,
                        ).italic.light,
                      ),
                    ),
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
