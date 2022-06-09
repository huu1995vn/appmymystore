import 'package:flutter/material.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/constants.dart';
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
                    itemProduct.urlImg,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
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
                        stops: const[
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              itemProduct.publishdate,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const Text(
                              ' | ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              itemProduct.webresourcename,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
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
