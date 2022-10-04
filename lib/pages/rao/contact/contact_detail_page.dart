// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../core/commons/common_configs.dart';

class ContactDetailPage extends StatefulWidget {
  final int? id;
  final ContactModel? item;
  final void Function(ContactModel)? onChanged;

  const ContactDetailPage({super.key, this.id, this.item, this.onChanged});

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  ContactModel? data;
  loadData() async {
    try {
      if (widget.item != null) {
        setState(() {
          data = widget.item;
        });
      } else {
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().contactbyid(widget.id!);
        if (res.status > 0) {
          setState(() {
            data = ContactModel.fromJson(res.data);
          });
        } else {
          CommonMethods.showToast(res.message);
        }
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
  }

  _onSave() async {
    CommonMethods.lockScreen();
    try {
      var dataClone = data!.clone();
      ResponseModel res = await DaiLyXeApiBLL_APIUser()
          .contactsavedata(dataClone.toDataSave(dataClone.id));
      if (res.status > 0) {
        if (widget.onChanged != null) widget.onChanged!(dataClone);
        if (dataClone.id > 0) {
          setState(() {
            data = dataClone;
          });
          CommonMethods.showToast("update.success".tr);
        } else {
          CommonNavigates.goBack(context);
          CommonMethods.showToast("create.success".tr);
        }
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }

    CommonMethods.unlockScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("info.concat".tr),
          elevation: 0.0,
        ),
        body: data == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color:
                    CommonConfig.isDark ? AppColors.blackLight : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                child: Form(
                    key: _keyValidationForm,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        rxTextInput(context, data!.fullname,
                            labelText: "fullname".tr,
                            onChanged: (v) => {data!.fullname = v},
                            validator: Validators.compose([
                              Validators.required("notempty.text".tr),
                            ])),
                        rxTextInput(context, data!.phone,
                            labelText: "phone".tr,
                            keyboardType: TextInputType.number,
                            onChanged: (v) => {data!.phone = v},
                            validator: (v) {
                              if (v == null || !v.isNotEmpty) {
                                return "notempty.text".tr;
                              } else {
                                return CommonMethods.checkStringPhone(v)
                                    ? null
                                    : "invalid.phone".tr;
                              }
                            }),
                        rxSelectInput(context, "city", data!.cityid,
                            afterChange: (v) => {
                                  setState(() {
                                    data!.cityid = v;
                                    data!.districtid = 0;
                                  })
                                },
                            validator: (v) {
                              if (!(data!.cityid > 0)) {
                                return "notempty.text".tr;
                              }
                              return null;
                            }),
                        rxSelectInput(context, "district", data!.districtid,
                            fnWhere: (item) {
                              return item["cityid"] == data!.cityid;
                            },
                            afterChange: (v) => {
                                  setState(() {
                                    data!.districtid = v;
                                  })
                                },
                            validator: (v) {
                              if (!(data!.districtid > 0)) {
                                return "notempty.text".tr;
                              }
                              return null;
                            }),
                        rxTextInput(context, data!.address,
                            labelText: "address".tr,
                            onChanged: (v) => {data!.address = v},
                            validator: Validators.compose([
                              Validators.required("notempty.text".tr),
                            ])),
                      ],
                    )),
              ),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                  child: RxPrimaryButton(
                      onTap: () {
                        if (_keyValidationForm.currentState!.validate()) {
                          _onSave();
                        }
                      },
                      text: 'save'.tr))
            ],
          )
        ]);
  }
}
