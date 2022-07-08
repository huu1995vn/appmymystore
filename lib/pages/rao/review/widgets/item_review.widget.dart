// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class ItemReviewWidget extends StatefulWidget {
  final ReviewModel item;
  final void Function()? onTap;
  final void Function(BuildContext)? onDelete;

  const ItemReviewWidget(this.item, {super.key, this.onTap, this.onDelete});
  @override
  State<ItemReviewWidget> createState() => _ItemReviewWidgetState();
}

class _ItemReviewWidgetState extends State<ItemReviewWidget> {
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
                  widget.item.productname?.toString() ?? "",
                  overflow: TextOverflow.ellipsis,
                  // style: TextStyle(FontWeight.normal),
                ),
                // isThreeLine: true,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RatingBar.builder(
                      initialRating:
                          CommonMethods.convertToDouble(widget.item.ratingvalue??0.0),
                      itemSize: 15.0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, _) => const Icon(
                        AppIcons.star_1,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_) {},
                    ),
                    Text(widget.item.comment ?? "",
                        style: const TextStyle().italic),
                  ],
                ),
                onTap: widget.onTap)));
  }
}
