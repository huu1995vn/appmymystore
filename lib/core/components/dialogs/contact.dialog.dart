// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/delegates/rx_select.delegate.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';

class ContactDialog extends StatefulWidget {
  const ContactDialog({
    super.key,
    required this.contact,
  });
  final ContactModel contact;
  @override
  State<ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends State<ContactDialog> {
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
      cityname = MasterDataService.getNameById(
          "city", contact.cityid);
      districtname = MasterDataService.getNameById(
          "district", contact.districtid);
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
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color, //change your color here
              ),
              centerTitle: true,
              title: Text("info.concat".tr(),
                  style: kTextHeaderStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyText1!.color)),
              elevation: 0.0,
              backgroundColor: AppColors.grey,
            ),
            SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                        key: _keyValidationForm,
                        child: Column(
                          children: [
                            Card(
                                child: Column(
                              children: <Widget>[
                                _selectInput(
                                  "city",
                                  int.parse(contact.cityid.toString()),
                                  afterChange: (v) => {
                                    setState(() {
                                      contact.cityid = v;
                                      contact.districtid = 0;
                                    })
                                  },
                                ),
                                _selectInput(
                                  "district",
                                  int.parse(contact.districtid.toString()),
                                  fnWhere: (v) {
                                    return v["cityid"] ==
                                        int.parse(contact.cityid.toString());
                                  },
                                  afterChange: (v) => {
                                    setState(() {
                                      contact.districtid = v;
                                    })
                                  },
                                ),
                                ListTile(
                                  title:
                                      Text("address".tr(), style: styleTitle),
                                  subtitle: SizedBox(
                                    height: 40,
                                    child: RxInput(
                                      contact.address!,
                                      hintText: "address".tr(),
                                      onChanged: (v) => {contact.address = v},
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            RxPrimaryButton(
                                onTap: () {
                                  if (_keyValidationForm.currentState!
                                      .validate()) {
                                    CommonNavigates.goBack(context, contact);
                                  }
                                },
                                text: 'save'.tr())
                          ],
                        ))))
          ],
        ));
  }

  Widget _selectInput(
    String type,
    dynamic id, {
    String? title,
    String hintText = "Chọn lọc",
    bool Function(dynamic)? fnWhere,
    dynamic Function(dynamic)? afterChange,
    bool isRequire = false,
  }) {
    var name = CommonMethods.getNameMasterById(type, id);
    return ListTile(
      title: RichText(
        text: TextSpan(
          text: title ?? type.tr(),
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            if (isRequire)
              TextSpan(
                  text: '*',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.primary)),
          ],
        ),
      ),
      subtitle: Text(name != null && name.length > 0 ? name : hintText,
          style: TextStyle(
              color:
                  name != null && name.length > 0 ? AppColors.primary : null)),
      onTap: () =>
          _onSelect(type, id, fnWhere: fnWhere, afterChange: afterChange),
      trailing: Icon(AppIcons.chevron_right),
    );
  }

  _onSelect(String type, dynamic id,
      {bool Function(dynamic)? fnWhere, Function(dynamic)? afterChange}) async {
    List data = MasterDataService.data[type];
    if (fnWhere != null) {
      data = data.where(fnWhere!).toList();
    }
    var res = await showSearch(
        context: context, delegate: RxSelectDelegate(data: data, value: id));
    if (res != null) {
      if (afterChange != null) afterChange!(res);
    }
  }
}
