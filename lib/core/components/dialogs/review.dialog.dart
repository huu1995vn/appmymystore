// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, import_of_legacy_library_into_null_safe

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:rating_bar/rating_bar.dart';

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
        CommonMethods.showToast("success".tr);
        CommonNavigates.goBack(context);
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
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(
              color: AppColors.black, //change your color here
            ),
            centerTitle: true,
            title: Text("review".tr,
                style: kTextHeaderStyle.copyWith(color: AppColors.black)),
            elevation: 0.0,
            backgroundColor: AppColors.grey,
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.all(kDefaultPaddingBox),
                  child: Form(
                      key: _keyValidationForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.product.name!,
                              style: kTextHeaderStyle.size(20)),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            child: RatingBar(
                              filledColor: AppColors.yellow,
                              size: 45,
                              initialRating: 5,
                              onRatingChanged: (_) {
                                review.ratingvalue = _.round();
                              },
                              emptyIcon: AppIcons.star_2,
                              filledIcon: AppIcons.star_2,
                            ),
                          ),
                          _header(
                            header: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "review".tr,
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
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "please.enter".tr,
                                  ),
                                  maxLength: 500,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.none,
                                  validator: (value) {
                                    if ((review.comment == null ||
                                        review.comment!.isEmpty)) {
                                      return "notempty".tr;
                                    }
                                    return null;
                                  },
                                )),
                          )
                        ],
                      ))))
        ],
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
                child: RxPrimaryButton(
                    onTap: () {
                      if (_keyValidationForm.currentState!.validate()) {
                        onSave();
                      }
                    },
                    text: 'sendreview'.tr))
          ],
        )
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
