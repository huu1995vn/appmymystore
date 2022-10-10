// ignore_for_file: unrelated_type_equality_checks

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
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
            child: Container(
                padding: EdgeInsets.symmetric(vertical: kDefaultPaddingBox),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black12),
                  ),
                ),
                child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: AppColors.grayDark,
                        child: FaIcon(
                          FontAwesomeIcons.mapMarkerAlt,
                          color: Colors.grey,
                        )),
                    title: Row(
                      children: [
                        Text(
                          widget.item.fullname ?? "NaN",
                          style: kTextTitleStyle,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.item.isdefault ? "(" + "default".tr + ")" : "",
                          style: const TextStyle(
                              color: AppColors.blue,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    // isThreeLine: true,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.item.cityid != null ||
                                widget.item.cityid > 0)
                              Text(
                                widget.item.cityname ?? "NaN",
                                style: const TextStyle(color: AppColors.blue),
                              ),
                            Text(
                              widget.item.phone ?? "NaN",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Text(
                          widget.item!.address ?? "NaN",
                          style: const TextStyle(),
                        )
                      ],
                    ),
                    onTap: widget.onTap))));
  }
}
