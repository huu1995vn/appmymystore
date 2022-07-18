// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, import_of_legacy_library_into_null_safe

import 'package:easy_localization/easy_localization.dart';
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
import 'package:scroll_to_index/scroll_to_index.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  int value = -1;
  bool showText = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  TextStyle styleTitle =
      kTextHeaderStyle.copyWith(fontSize: 15, fontWeight: FontWeight.normal);
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  ReviewModel review = ReviewModel();
  late AutoScrollController scrollController = AutoScrollController();

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
      };
      ResponseModel res = await DaiLyXeApiBLL_APIUser().reportpost(body);
      if (res.status > 0) {
        CommonMethods.showDialogSuccess(context, "success".tr());
      } else {
        CommonMethods.showToast(context, res.message);
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
        controller: scrollController,
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
                      child: Card(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (int i = 0; i < REPORTS.length; i++)
                            ListTile(
                                title: Text(
                                  REPORTS[i],
                                ),
                                leading: Radio(
                                  value: i,
                                  groupValue: value,
                                  onChanged: ((v) {
                                    setState(() {
                                      value = v as int;
                                      review.comment = REPORTS[value as int];
                                      showText = false;
                                    });
                                  }),
                                )),
                          ListTile(
                              title: Text(
                                "Lý do khác",
                              ),
                              leading: Radio(
                                value: 9999,
                                groupValue: value,
                                onChanged: ((v) {
                                  setState(() {
                                    value = v as int;
                                    showText = true;
                                    Future.delayed(const Duration(milliseconds: 100), () {
                                      scrollController.jumpTo(scrollController
                                          .position.maxScrollExtent);
                                    });
                                  });
                                }),
                              )),
                          if (showText)
                            Padding(
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
                                    hintText: "enter.text".tr(),
                                  ),
                                  maxLength: 500,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.none,
                                  validator: (value) {
                                    if ((review.comment == null ||
                                        review.comment!.isEmpty)) {
                                      return "notempty.text".tr();
                                    }
                                    return null;
                                  },
                                )),
                        ],
                      )))))
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
