import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemNotificationWidget extends StatelessWidget {
  final NotificationModel itemNotification;
  final void Function(BuildContext)? onDelete;
  final void Function()? onTap;
  const ItemNotificationWidget(this.itemNotification,
      {super.key, this.onDelete, this.onTap});

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
            icon: AppIcons.trash_1,
            label: 'delete.text'.tr(),
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: ListTile(
        onTap: onTap,
        title: Text(
          itemNotification.subject,
          overflow: TextOverflow.ellipsis,
          // style: TextStyle(FontWeight.normal),
        ),
        leading: const CircleAvatar(
            backgroundColor: AppColors.grayDark,
            child: Icon(AppIcons.alarm, color: AppColors.primary800, size: 30)),
        subtitle: Text(itemNotification.rxtimeago),
      ),
    );
  }
}
