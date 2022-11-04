// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mymystore/core/commons/index.dart';
import 'package:mymystore/core/components/part.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/services/master_data.service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/utilities/constants.dart';
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(
              color: AppColors.white, //change your color here
            ),
            centerTitle: true,
            title: Text("Địa chỉ"),
            elevation: 0.0,
          ),
          SliverToBoxAdapter(
              child: Form(
                  key: _keyValidationForm,
                  child: Card(
                    margin: EdgeInsets.only(top: kDefaultMarginBottomBox),
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
                              return "notempty".tr;
                            }
                            return null;
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
                              return "notempty".tr;
                            }
                            return null;
                          }),
                      rxTextInput(context, contact.address,
                          labelText: "address".tr,
                          onChanged: (v) => {contact.address = v},
                          validator: Validators.compose([
                            Validators.required("notempty".tr),
                          ])),
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
                        CommonNavigates.goBack(context, contact);
                      }
                    },
                    text: 'save'.tr))
          ],
        )
      ],
    );
  }
}
