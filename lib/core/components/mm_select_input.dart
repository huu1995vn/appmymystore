import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/components/delegates/mm_select.delegate.dart';
import 'package:mymystore/core/components/mm_input.dart';
import 'package:mymystore/core/services/master_data.service.dart';

import '../commons/common_methods.dart';

class MMSelectInput extends StatelessWidget {
  final String type;
  final int id;
  final String? labelText;
  final String? hintText;
  final bool isBorder = false;
  final bool Function(dynamic)? fnWhere;
  final dynamic Function(dynamic)? afterChange;
  final String? Function(String?)? validator;
  const MMSelectInput(this.type, 
      {super.key,
      this.id = -1,
      this.labelText,
      this.hintText,
      this.fnWhere,
      this.afterChange,
      this.validator});

  _onSelect(BuildContext context, String type, dynamic id,
      {bool Function(dynamic)? fnWhere, Function(int)? afterChange}) async {
    List data = [];
    if (type == "year") {
      int start = 1970;
      for (var i = DateTime.now().year + 1; i >= start; i--) {
        data.add({"name": i.toString(), "id": i});
      }
    } else {
      data = MasterDataService.data[type];
    }
    if (fnWhere != null) {
      data = data.where(fnWhere).toList();
    }

    data = [
      {"name": "all".tr, "id": -1},
      ...data
    ];
    var res = await showSearch(
        context: context, delegate: MMSelectDelegate(data: data, value: id));
    if (res != null) {
      if (afterChange != null) afterChange(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    var name = CommonMethods.getNameMasterById(type, id);
    if (id == null || id == -1) {
      name = "all".tr;
    }
    return MMInput(name,
        isBorder: isBorder,
        readOnly: true,
        labelText: labelText ?? type.tr,
        hintText: hintText ?? "choose".tr,
        style: const TextStyle(fontSize: 16),
        suffixIcon: const Icon(AppIcons.chevron_right),
        validator: validator, onTap: () {
      _onSelect(context, type, id, fnWhere: fnWhere, afterChange: afterChange);
    });
  }
}
