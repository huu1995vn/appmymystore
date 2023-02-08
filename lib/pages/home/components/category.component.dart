import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/components/mm_part.dart';

class CategoryComponent extends StatelessWidget {
  CategoryComponent({Key? key}) : super(key: key);

  var buttons = [
    MMButtonMenu(
      icon: AppIcons.cart,
      label: "Đơn hàng",
      onPressed: () {},
    ),
    MMButtonMenu(
      icon: AppIcons.book_1,
      label: "Sản phẩm",
      onPressed: () {},
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
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category",
            style: CommonConstants.kTextHeaderStyle,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buttons
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.all(10),
                      child: e,
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
