import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';

class Category {
  const Category(this.icon, this.title, this.id);

  final Icon icon;
  final String title;
  final String id;
}

final homeCategries = <Category>[
  const Category(Icon(AppIcons.shopping_cart), 'Đơn hàng', 'sofa'),
  const Category(Icon(AppIcons.assignment), 'Sản phẩm', 'sofa'),
  const Category(Icon(AppIcons.chart_bars), 'Báo cáo', 'sofa'),
  const Category(Icon(AppIcons.account_balance), 'Kho hàng', 'sofa'),
  // const Category('assets/icons/category_others@2x.png', 'Khác', 'sofa'),
];
