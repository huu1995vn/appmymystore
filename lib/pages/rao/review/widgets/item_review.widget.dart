// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
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
                RatingBar.builder(
                  initialRating: CommonMethods.convertToDouble(
                      widget.item.ratingvalue ?? 0.0),
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
                  color:
                      AppColors.grey, // <-- Red color provided to below Row
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RxImage(widget.item.rximg, width: 39, height: 39,),
                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Text(
                          widget.item.name!,
                          style:
                              const TextStyle().size(12),
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
