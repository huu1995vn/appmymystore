import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemNotifycationWidget extends StatelessWidget {
  final NewsModel itemNews;

  const ItemNotifycationWidget(this.itemNews, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        itemNews.desc,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            // fontSize: 16,
            fontWeight: true ? FontWeight.normal : FontWeight.w700),
      ),
      
      leading: const CircleAvatar(
          backgroundColor: AppColors.grayDark,
          child:
              Icon(Icons.notifications, color: AppColors.primary800, size: 30)),
      subtitle: Text(itemNews.publishdate),
      isThreeLine: true,
      onTap: () {
        // onSelected(context, index);
      },
    );
  }
}
