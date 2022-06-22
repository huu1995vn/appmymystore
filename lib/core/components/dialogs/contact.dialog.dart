// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/dialogs/select/select.dialog.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ContactDialog extends StatefulWidget {
  const ContactDialog({
    super.key,
    required this.contact,
  });
  final ContactModel contact;
  @override
  State<ContactDialog> createState() => _UserPageState();
}

class _UserPageState extends State<ContactDialog> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  String cityname = "";
  String districtname = "";
  String address = "";
  ContactModel contact = ContactModel();
  loadData() {
    setState(() {
      contact = widget.contact;
      cityname =
          MasterDataService.getNameById("city", int.parse(contact.cityid));
      districtname = MasterDataService.getNameById(
          "district", int.parse(contact.districtid));
    });
  }

  _onCity() async {
    var res = await showSearch(
        context: context,
        delegate: SelectDelegate(
            data: MasterDataService.data["city"],
            value: int.parse(contact.cityid)));
    if (res != null) {
      setState(() {
        contact.cityid = res.toString();
        cityname = MasterDataService.getNameById("city", res);
        contact.districtid = "-1";
        districtname = "";
      });
    }
  }

  _onDistrict() async {
    int cityid = int.parse(contact.cityid ?? "-1");
    var district = cityid > 0
        ? MasterDataService.data["district"]
            .where((element) => element['cityid'] == cityid)
            .toList()
        : [];
    var res = await showSearch(
        context: context,
        delegate: SelectDelegate(
            data: district, value: int.parse(contact.districtid)));
    if (res != null) {
      setState(() {
        contact.districtid = res.toString();
        districtname = MasterDataService.getNameById("district", res);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("info.concat".tr(), style: kTextHeaderStyle),
            elevation: 0.0,
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _keyValidationForm,
              child: Column(
                children: <Widget>[
                  RxInput(
                    cityname,
                    readOnly: true,
                    hintText: "city".tr(),
                    onChanged: (v) => {cityname = v},
                    validator: Validators.compose([
                      Validators.required("notempty.city.text".tr()),
                    ]),
                    onTap: _onCity,
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                  ),
                  RxInput(
                    districtname,
                    readOnly: true,
                    hintText: "district".tr(),
                    onChanged: (v) => {districtname = v},
                    validator: Validators.compose([
                      Validators.required("notempty.district.text".tr()),
                    ]),
                    onTap: _onDistrict,
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                  ),
                  RxInput(contact.address,
                      hintText: "address".tr(),
                      // icon: const Icon(Icons.person),
                      onChanged: (v) => {contact.address = v},
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
                CommonNavigates.goBack(context, contact);
              }
            },
            text: 'save'.tr()),
      ),
    );
  }
}
