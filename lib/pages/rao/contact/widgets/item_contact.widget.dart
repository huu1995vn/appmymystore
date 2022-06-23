// ignore_for_file: unrelated_type_equality_checks

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class ItemContactWidget extends StatefulWidget {
  final ContactModel item;
  final void Function()? onTap;
  final void Function()? onDelete;
  const ItemContactWidget(this.item, {super.key, this.onTap, this.onDelete});
  @override
  State<ItemContactWidget> createState() => _ItemContactWidgetState();
}

class _ItemContactWidgetState extends State<ItemContactWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: RxCircleAvatar(
          child: Icon(Icons.contact_page_rounded,
              size: 30, color: Colors.blue[500])),
      title: Wrap(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(widget.item.fullname, style: const TextStyle().bold),
          ),
          if (widget.item.ISDEFAULT)
            Text("default".tr(),
                style: const TextStyle(color: AppColors.info).italic)
        ],
      ),
      isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.item.phone, style: const TextStyle().italic),
          const SizedBox(
            height: 5,
          ),
          Text(widget.item.address, style: const TextStyle().italic),
        ],
      ),
      trailing: GestureDetector(
        onTap: widget.onDelete,
        child: Ink(
          decoration: const ShapeDecoration(
            // color: AppColors.grayDark,
            shape: CircleBorder(),
          ),
          child: const Icon(
            Icons.close,
            color: AppColors.black50,
          ),
        ),
      ),
      onTap: widget.onTap,
    ));
  }
}
