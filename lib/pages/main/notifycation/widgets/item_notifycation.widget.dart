import 'package:flutter/material.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

class ItemNotifycationWidget extends StatelessWidget {
  final NewsModel itemNews;

  const ItemNotifycationWidget(this.itemNews, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        itemNews.desc,
        overflow: TextOverflow.ellipsis,
        // style: TextStyle(FontWeight.normal),
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
