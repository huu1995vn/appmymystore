// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, import_of_legacy_library_into_null_safe

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

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
  bool showText = false;
  List<dynamic> reporttype = <dynamic>[];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  TextStyle styleTitle =
      kTextHeaderStyle.copyWith(fontSize: 15, fontWeight: FontWeight.normal);
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  ReportModel report = ReportModel();
  late AutoScrollController scrollController = AutoScrollController();

  loadData() {
    setState(() {
      report.productid = widget.product.id;
      reporttype = MasterDataService.data["reporttype"] ?? <dynamic>[];
    });
  }

  onSave() async {
    try {
      Map<String, dynamic> body = {
        "id": widget.product.id,
        "note": report.note,
        "type": report.reporttypeid
      };
      ResponseModel res = await DaiLyXeApiBLL_APIUser().reportpost(body);
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
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(
              color: AppColors.black, //change your color here
            ),
            centerTitle: true,
            title: Text("report.violation".tr,
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
                          for (int i = 0; i < reporttype.length; i++)
                            ListTile(
                                title: Text(
                                  reporttype[i]["name"],
                                ),
                                leading: Radio(
                                  value: reporttype[i]["id"],
                                  groupValue: report.reporttypeid,
                                  onChanged: ((v) {
                                    setState(() {
                                      report.reporttypeid = v as int;
                                      showText = report.reporttypeid == 1;
                                      if (report.reporttypeid == 1) {
                                        Future.delayed(
                                            const Duration(milliseconds: 100),
                                            () {
                                          scrollController.jumpTo(
                                              scrollController
                                                  .position.maxScrollExtent);
                                        });
                                      }
                                    });
                                  }),
                                )),
                          if (showText)
                            Padding(
                                padding: kEdgeInsetsPadding,
                                child: 
                                rxTextInput(
                                      context, report.note?? "",
                                      labelText: "description".tr,
                                      hintText: "please.enter".tr,
                                      keyboardType: TextInputType.multiline,
                                      maxLength: 500,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.none,
                                      minLines: 6, 
                                      onChanged: (v) {
                                    setState(() {
                                      report.note = v;
                                    });
                                  },
                                      validator: Validators.compose([
                                        Validators.required("notempty".tr),
                                      ]))
                               
                                ),
                        ],
                      )))))
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
                    text: 'sendreport'.tr))
          ],
        )
      ],
    );
  }
}
