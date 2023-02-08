import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/components/mm_image.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/utilities/size_config.dart';

class ItemProductWidget extends StatelessWidget {
  final ProductModel item;
  final void Function()? onTap;

  const ItemProductWidget(this.item, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MMCard(
      child: Container(
          padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.black12),
            ),
          ),
          child: GestureDetector(
            onTap: onTap,
            child: SizedBox(
              height: SizeConfig.screenWidth / 4.3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child:
                        MMImage(item.mmimg!, width: SizeConfig.screenWidth / 4),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: CommonConstants.kDefaultPadding),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Product")
                                
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
