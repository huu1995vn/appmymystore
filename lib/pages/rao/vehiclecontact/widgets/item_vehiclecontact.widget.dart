// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/entities.dart';
// ignore: unused_import
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class ItemVehicleContactWidget extends StatelessWidget {
  final VehicleContactModel item;
  final void Function()? onTap;
  final void Function(BuildContext) onDelete;
  const ItemVehicleContactWidget(this.item,
      {super.key, this.onTap, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container( 
              decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black12),
                ),
              ), 
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
            child:  ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: CircleAvatar(
                      backgroundColor: AppColors.grayDark,
                      child: FaIcon(item.status == 1? FontAwesomeIcons.solidEnvelope: FontAwesomeIcons.solidEnvelopeOpen,
                          color: (item.status == 1
                              ? AppColors.primary
                              : AppColors.black50),
                          size: 20)),
                  title: Text(item.subject!,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 16, fontWeight: item.status == 1? FontWeight.bold: FontWeight.normal)),
                  subtitle: Transform.translate(
                    offset: const Offset(0, 10),
                    child: Text(item.message!, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  isThreeLine: true,
                  onTap: onTap,
                ))));
  }
}
