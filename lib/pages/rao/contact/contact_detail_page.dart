// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/dialogs/select/select.dialog.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/theme_provider.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ContactDetailPage extends StatefulWidget {
  final int? id;
  final ContactModel? item;

  const ContactDetailPage({super.key, this.id, this.item});

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
            await DaiLyXeApiBLL_APIUser().advertdetail(widget.id!);
        if (res.status > 0) {
          List<dynamic> ldata = jsonDecode(res.data);
          setState(() {
            data = ContactModel.fromJson(ldata[0]);
          });
        } else {
          CommonMethods.showToast(res.message);
        }
      }
      // data!.cityname =
      //     MasterDataService.getNameById("city", int.parse(data!.cityid));
      // data!.districtname = MasterDataService.getNameById(
      //     "district", int.parse(data!.districtid));
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
  }

  _onCity() async {
        int cityid = data!.cityid == null ? -1 : int.parse(data!.cityid);

    var res = await showSearch(
        context: context,
        delegate: SelectDelegate(
            data: MasterDataService.data["city"],
            value: cityid));
    if (res != null) {
      setState(() {
        data!.cityid = res.toString();
        data!.cityname = MasterDataService.getNameById("city", res ?? "-1");
        data!.districtid = "-1";
        data!.districtname = "";
      });
    }
  }

  _onDistrict() async {
    int cityid = data!.cityid == null ? -1 : int.parse(data!.cityid);
    int districtid =
        data!.districtid == null ? -1 : int.parse(data!.districtid);
    var district = cityid > 0
        ? MasterDataService.data["district"]
            .where((element) => element['cityid'] == cityid)
            .toList()
        : [];
    var res = await showSearch(
        context: context,
        delegate:
            SelectDelegate(data: district, value: districtid));
    if (res != null) {
      setState(() {
        data!.districtid = res.toString();
        data!.districtname =
            MasterDataService.getNameById("district", res ?? "-1");
      });
    }
  }

  _onSave() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  iconTheme: IconThemeData(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color, //change your color here
                  ),
                  centerTitle: true,
                  title: Text("info.concat".tr(),
                      style: kTextHeaderStyle.copyWith(
                          color: Theme.of(context).textTheme.bodyText1!.color)),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _keyValidationForm,
                    child: Column(
                      children: <Widget>[
                        RxInput(data!.fullname,
                            isBorder: true,
                            labelText: "fullname".tr(),
                            onChanged: (v) => {
                                  setState(() => {data!.fullname = v})
                                },
                            validator: Validators.compose([
                              Validators.required(
                                  "notempty.fullname.text".tr()),
                            ])),
                        RxInput(data!.phone,
                            isBorder: true,
                            keyboardType: TextInputType.number,
                            labelText: "phone".tr(),
                            onChanged: (v) => {
                                  setState(() => {data!.phone = v})
                                },
                            validator: (v) {
                              if (v == null || !v.isNotEmpty) {
                                return "notempty.phone.text".tr();
                              } else {
                                return CommonMethods.checkStringPhone(v)
                                    ? null
                                    : "invalid.phone".tr();
                              }
                            }),
                        RxInput(
                          data!.cityname ?? "",
                          isBorder: true,
                          readOnly: true,
                          labelText: "city".tr(),
                          onChanged: (v) => {data!.cityname = v},
                          validator: Validators.compose([
                            Validators.required("notempty.city.text".tr()),
                          ]),
                          onTap: _onCity,
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                        ),
                        RxInput(
                          data!.districtname ?? "",
                          isBorder: true,
                          readOnly: true,
                          labelText: "district".tr(),
                          onChanged: (v) => {data!.districtname = v},
                          validator: Validators.compose([
                            Validators.required("notempty.district.text".tr()),
                          ]),
                          onTap: _onDistrict,
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                        ),
                        RxInput(data!.address,
                            isBorder: true,
                            labelText: "address".tr(),
                            onChanged: (v) => {data!.address = v},
                            validator: Validators.compose([
                              Validators.required("notempty.address.text".tr()),
                            ])),
                      ],
                    ),
                  ),
                ))
              ],
            ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: RxPrimaryButton(
            onTap: () {
              if (_keyValidationForm.currentState!.validate()) {
                _onSave();
              }
            },
            text: 'save'.tr()),
      ),
    );
  }
}
