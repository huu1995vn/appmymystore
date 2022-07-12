// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:rating_bar/rating_bar.dart';

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
    return Card(
        child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: [
                    RxAvatarImage(widget.item.rximguser, size: 25),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        widget.item.username ?? "NAN",
                        style: const TextStyle().size(12),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: RatingBar.readOnly(
                  filledColor: AppColors.yellow,
                  size: 15,
                  initialRating: 5,
                  emptyIcon: AppIcons.star_1,
                  filledIcon: AppIcons.star_1,
                )) ,
                Text(widget.item.rxtimeago, style: kTextTimeStyle),
              ],
            ),
            // isThreeLine: true,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Container(
                  height: 39,
                  color: AppColors.grey, // <-- Red color provided to below Row
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RxImage(
                        widget.item.rximg,
                        width: 39,
                        height: 39,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Text(
                          widget.item.name!,
                          style: const TextStyle().size(12),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(widget.item.comment ?? "",
                    style: const TextStyle().italic, maxLines: 6),
              ],
            ),
            onTap: widget.onTap));
  }
}
