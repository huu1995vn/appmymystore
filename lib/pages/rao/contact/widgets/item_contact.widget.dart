// ignore_for_file: unrelated_type_equality_checks

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class ItemContactWidget extends StatefulWidget {
  final ContactModel item;
  final void Function()? onTap;
  final void Function(BuildContext)? onDelete;
  final void Function(BuildContext)? onDefault;

  const ItemContactWidget(this.item,
      {super.key, this.onTap, this.onDelete, this.onDefault});
  @override
  State<ItemContactWidget> createState() => _ItemContactWidgetState();
}

class _ItemContactWidgetState extends State<ItemContactWidget> {
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
              onPressed: widget.onDelete,
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
              icon: AppIcons.trash_1,
              label: 'delete'.tr,
            ),
            SlidableAction(
              onPressed: widget.onDefault,
              backgroundColor: AppColors.info,
              foregroundColor: Colors.white,
              icon: AppIcons.checkmark_cicle,
              label: 'default'.tr,
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Card(
            child: ListTile(
                leading: RxIconButton(
                  icon: AppIcons.map_marker,
                  colorIcon: AppColors.blue,
                  size: 45,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.item.fullname ?? "",
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.item.isdefault)
                      Text(
                        "default".tr,
                        style: const TextStyle(color: AppColors.info),
                      )
                  ],
                ),
                // isThreeLine: true,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.item.phone ?? "",
                        style: const TextStyle().italic),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(widget.item.address ?? "",
                        style: const TextStyle().italic),
                  ],
                ),
                onTap: widget.onTap)));
  }
}
