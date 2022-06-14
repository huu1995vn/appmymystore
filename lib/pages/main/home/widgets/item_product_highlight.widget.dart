import 'package:flutter/material.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemProductHighlightWidget extends StatelessWidget {
  final ProductModel itemProduct;

  const ItemProductHighlightWidget(this.itemProduct, {super.key});

  @override
  Widget build(BuildContext context) {
    return RxCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          // onSelected(context);
        },
        child: Container(
          height: SizeConfig.screenHeight / 4,
          width: SizeConfig.screenWidth - 30,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            image: DecorationImage(
              image: NetworkImage(
                itemProduct.URLIMG,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.black.withOpacity(0.0),
                    ],
                    stops: const [
                      0.0,
                      1.0,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      itemProduct.name,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "4.000.000.000 đ",
                      style: const TextStyle(color: AppColors.primary, fontSize: 15)
                          .bold,
                    ),
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
                          color: AppColors.white,
                          fontSize: 10,
                        ).textOpacity(0.5).italic.light,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 10.0,
                right: 10,
                child: Row(
                  children: [
                    const Icon(
                      Icons.military_tech_outlined,
                      color: AppColors.yellow,
                    ),
                    Text(
                      " Tin ưu tiên",
                      style: const TextStyle(color: AppColors.yellow).bold,
                    )
                  ],
                ), //Icon
              ), //Positioned
            ],
          ),
        ),
      ),
    );
  }
}
