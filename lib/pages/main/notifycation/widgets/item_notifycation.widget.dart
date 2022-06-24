import 'package:flutter/material.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemNotifycationWidget extends StatelessWidget {
  final NewsModel itemNews;
  final void Function(BuildContext)? onDelete;
  const ItemNotifycationWidget(this.itemNews, {super.key, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: AppColors.danger,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: ListTile(
        title: Text(
          itemNews.desc,
          overflow: TextOverflow.ellipsis,
          // style: TextStyle(FontWeight.normal),
        ),
        leading: const CircleAvatar(
            backgroundColor: AppColors.grayDark,
            child: Icon(Icons.notifications,
                color: AppColors.primary800, size: 30)),
        subtitle: Text(itemNews.publishdate),
      ),
    );
  }
}
