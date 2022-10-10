import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:raoxe/core/utilities/constants.dart';

class ItemNotificationWidget extends StatelessWidget {
  final NotificationModel item;
  final void Function(BuildContext)? onDelete;
  final void Function()? onTap;
  const ItemNotificationWidget(this.item,
      {super.key, this.onDelete, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Slidable(
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
                  label: 'delete'.tr,
                ),
              ],
            ),

            // The child of the Slidable is what the user sees when the
            // component is not dragged.
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingBox),
              child: ListTile(
                onTap: onTap,
                title: Text(
                  item.subject,
                  style: TextStyle(
                      fontWeight: item.status != 1
                          ? FontWeight.normal
                          : FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                leading: CircleAvatar(
                    backgroundColor: AppColors.grayDark,
                    child: FaIcon(FontAwesomeIcons.solidBell,
                        color: (item.status != 1
                            ? AppColors.black50
                            : AppColors.primary800),
                        size: 20)),
                subtitle: Text(
                  item.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )));
  }
}
