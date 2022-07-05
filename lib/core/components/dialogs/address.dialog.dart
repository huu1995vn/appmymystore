// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class AddressDialog extends StatefulWidget {
  const AddressDialog({
    super.key,
    required this.contact,
  });
  final ContactModel contact;
  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  TextStyle styleTitle =
      kTextHeaderStyle.copyWith(fontSize: 15, fontWeight: FontWeight.normal);
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  String cityname = "";
  String districtname = "";
  String address = "";
  ContactModel contact = ContactModel();
  loadData() {
    setState(() {
      contact = widget.contact;
      cityname = MasterDataService.getNameById("city", contact.cityid);
      districtname =
          MasterDataService.getNameById("district", contact.districtid);
    });
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
            title: Text("Địa chỉ",
                style: kTextHeaderStyle.copyWith(
                    color: AppColors.black)),
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
                        children: <Widget>[
                          rxSelectInput(context, "city", contact.cityid,
                              afterChange: (v) => {
                                    setState(() {
                                      contact.cityid = v;
                                      contact.districtid = 0;
                                    })
                                  },
                              validator: (v) {
                                if (!(contact.cityid > 0)) {
                                  return "notempty.text".tr();
                                }
                              }),
                          rxSelectInput(context, "district", contact.districtid,
                              fnWhere: (item) {
                                return item["cityid"] == contact.cityid;
                              },
                              afterChange: (v) => {
                                    setState(() {
                                      contact.districtid = v;
                                    })
                                  },
                              validator: (v) {
                                if (!(contact.districtid > 0)) {
                                  return "notempty.text".tr();
                                }
                              }),
                          rxTextInput(context, contact.address,
                              labelText: "address".tr(),
                              onChanged: (v) => {contact.address = v},
                              validator: Validators.compose([
                                Validators.required("notempty.text".tr()),
                              ])),
                        ],
                      )))))
        ],
      ),
      persistentFooterButtons: [
        RxPrimaryButton(
            onTap: () {
              if (_keyValidationForm.currentState!.validate()) {
                CommonNavigates.goBack(context, contact);
              }
            },
            text: 'save'.tr())
      ],
    );
  }
}