// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class ItemContactWidget extends StatefulWidget {
  final ContactModel item;
  final void Function()? onTap;
  final void Function(BuildContext)? onDelete;

  const ItemContactWidget(this.item,
      {super.key, this.onTap, this.onDelete});
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
              label: 'Delete',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Card(
            child: ListTile(
                leading: RxCircleAvatar(
                    child: Icon(AppIcons.map_marker,
                        size: 30, color: Colors.blue[500])),
                title: Text(
                  widget.item.fullname ?? "",
                  overflow: TextOverflow.ellipsis,
                  // style: TextStyle(FontWeight.normal),
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
