import 'package:flutter/material.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemProductWidget extends StatelessWidget {
  final ProductModel itemProduct;

  const ItemProductWidget(this.itemProduct, {super.key});

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
                borderRadius: BorderRadius.circular(5),
                child: RxImage(itemProduct.urlImg,
                    width: SizeConfig.screenWidth / 4),
              ),
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
                            itemProduct.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                // fontSize: 36,
                                ),
                          ),
                          Text(
                            "4.000.000 đ",
                            style: const TextStyle(
                              color: AppColors.primary,
                            ).bold,
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   itemProduct.webresourcename,
                    //   style: const TextStyle(
                    //     color: AppColors.yellow,
                    //     // fontSize: 28,
                    //   ),
                    // ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "${itemProduct.publishdate} | ",
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic)),
                          TextSpan(
                              text: "${itemProduct.views} lượt xem",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                        style: const TextStyle(
                          // color: AppColors.black50,
                          fontSize: 10,
                        ).textOpacity(0.5).italic.light,
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