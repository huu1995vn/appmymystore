// ignore_for_file: unrelated_type_equality_checks, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/commons/common_methods.dart';
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
        child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
                padding: const EdgeInsets.all(kDefaultPaddingBox),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: RxImage(
                          widget.item.rximg,
                        ),
                      )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: kDefaultPaddingBox),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.item.name!,
                            style: kTextTitleStyle,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.item.rxtimeago,
                                  style: kTextTimeStyle),
                              RatingBar.readOnly(
                                filledColor: AppColors.yellow,
                                size: 20,
                                initialRating: CommonMethods.convertToDouble(
                                    widget.item.ratingvalue),
                                emptyIcon: AppIcons.star_2,
                                filledIcon: AppIcons.star_2,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(widget.item.comment ?? "",
                              style: const TextStyle(), maxLines: 6),
                          const SizedBox(height: 5),
                          Text(
                              widget.item.status == 2
                                  ? widget.item.reject ?? "error"
                                  : "",
                              style: const TextStyle(color: AppColors.danger)
                                  .italic)
                        ]),
                  )),
                ]))));
  }
}
