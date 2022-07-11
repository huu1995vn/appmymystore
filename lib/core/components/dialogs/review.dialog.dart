// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class ReviewDialog extends StatefulWidget {
  const ReviewDialog({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  TextStyle styleTitle =
      kTextHeaderStyle.copyWith(fontSize: 15, fontWeight: FontWeight.normal);
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  ReviewModel review = ReviewModel();

  loadData() {
    setState(() {
      review.productid = widget.product.id;
    });
  }

  onSave() async {
    try {
      Map<String, dynamic> body = {
        "id": widget.product.id,
        "comment": review.comment,
        "ratingvalue": review.ratingvalue
      };
      ResponseModel res = await DaiLyXeApiBLL_APIUser().reviewpost(body);
      if (res.status > 0) {
        CommonNavigates.goBack(context, review);
        CommonMethods.showDialogSuccess(context, "Đánh giá thành công");
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(
              color: AppColors.black, //change your color here
            ),
            centerTitle: true,
            title: Text("",
                style: kTextHeaderStyle.copyWith(color: AppColors.black)),
            elevation: 0.0,
            backgroundColor: AppColors.grey,
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Form(
                      key: _keyValidationForm,
                      child: Column(
                        children: <Widget>[
                          RatingBar.builder(
                            initialRating: 5,
                            itemSize: 39.0,
                            ignoreGestures: false,
                            minRating: 0,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              AppIcons.star_1,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (_) {
                              review.ratingvalue =
                                  CommonMethods.convertToInt32(_);
                            },
                          ),
                          _header(
                            header: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Đánh giá ",
                                      style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color)
                                          .bold),
                                  const TextSpan(
                                      text: "*",
                                      style:
                                          TextStyle(color: AppColors.primary)),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                                padding: kEdgeInsetsPadding,
                                child: TextFormField(
                                  showCursor: true,
                                  key: const Key("review"),
                                  initialValue: review.comment,
                                  minLines:
                                      6, // any number you need (It works as the rows for the textarea)
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onChanged: (value) =>
                                      {review.comment = value},
                                  validator: (value) {
                                    if ((review.comment == null ||
                                        review.comment!.isEmpty)) {
                                      return "notempty.text".tr();
                                    }
                                  },
                                )),
                          )
                        ],
                      ))))
        ],
      ),
      persistentFooterButtons: [
        RxPrimaryButton(
            onTap: () {
              if (_keyValidationForm.currentState!.validate()) {
                onSave();
              }
            },
            text: 'save'.tr())
      ],
    );
  }

  Widget _header({String? title, Widget? header, Widget? action}) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding)
          .copyWith(left: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          header ??
              Text(
                title!,
                style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color)
                    .bold,
              ),
          if (action != null) action
        ],
      ),
    );
  }
}
