// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/commons/common_navigates.dart';
import 'package:mymystore/core/components/mm_part.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MMButtonMenu(
              icon: AppIcons.cart,
              label: "Đơn hàng",
              onPressed: () {},
            ),
             MMButtonMenu(
              icon: AppIcons.book_1,
              label: "Sản phẩm",
              onPressed: () {
                CommonNavigates.toProductPage(context);
              },
            ),
            MMButtonMenu(
              icon: AppIcons.attach_money,
              label: "Báo cáo",
              onPressed: () {},
            ),
            MMButtonMenu(
              icon: AppIcons.store,
              label: "Kho",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
