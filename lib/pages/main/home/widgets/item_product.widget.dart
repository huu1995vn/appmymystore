import 'dart:math';
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
    int lenimg = Random().nextInt(15); //itemProduct.LISTURLIMG.length

    return RxCard(
      child: GestureDetector(
        onTap: () async {},
        child: SizedBox(
          height: SizeConfig.screenWidth / 4.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(kDefaultPadding),
                      topLeft: Radius.circular(kDefaultPadding)),
                  child: Stack(
                    children: <Widget>[
                      RxImage(itemProduct.URLIMG,
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
                                  style: TextStyle(color: AppColors.white)
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
                  child: 
                  Stack(children: [
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          itemProduct.name ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              // fontSize: 36,
                              ),
                        ),
                      ),
                      Row(
                        // spacing: kDefaultPadding,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            itemProduct.price ?? "4.000.000",
                            style: const TextStyle(
                              color: AppColors.primary,
                            ).bold,
                          ),
                          
                          Text(
                            "Tin ưu tiên",
                            style: const TextStyle(
                              color: AppColors.yellow,
                            ).bold.size(12),
                          ),
                          const Icon(Icons.favorite_border_outlined, color: AppColors.black50, size: 19,)
                         
                        ],
                      ),
                    ],
                  ),
                  ],)
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
