// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/delegates/rx_select.delegate.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_input.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    super.key,
    required this.searchParams,
  });
  final Map<String, dynamic> searchParams;
  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> searchParams = {};
  Map<String, dynamic> names = {};
  @override
  initState() {
    super.initState();
    setState(() {
      searchParams = widget.searchParams ?? {};
    });
  }

  _onDone() {
    CommonNavigates.goBack(context, searchParams);
  }

  _onSelect(String type, int id,
      {bool Function(dynamic)? fnWhere, Function()? afterChange}) async {
    List data = MasterDataService.data[type];
    if (fnWhere != null) {
      data = data.where(fnWhere!).toList();
    }
    var res = await showSearch(
        context: context, delegate: RxSelectDelegate(data: data, value: id));
    if (res != null) {
      setState(() {
        searchParams[type] = res;
        if (afterChange != null) afterChange!();
      });
    }
  }

  String getNameById(String type, int id) {
    try {
      return (MasterDataService.data[type] as List)
          .firstWhere((element) => element["id"] == id)["name"];
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(context) {
    return RxScaffold(
      appBar: AppBar(
        title: Text(
          'Bộ lọc',
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: RxWrapper(
          body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: [_selectInput("brand")],
                ),
                _selectInput("bodytype",
                    afterChange: () => {searchParams["model"] = null}),
                _selectInput("model", fnWhere: (v) {
                  return v["bodytypeid"] == searchParams["bodytype"];
                }),
                _selectInput("city"),
                //Gia
                //Sort
                RxPrimaryButton(
                  onTap: _onDone,
                  text: "Done",
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _selectInput(
    String type, {
    bool Function(dynamic)? fnWhere,
    dynamic Function()? afterChange,
  }) {
    return RxInput(
      getNameById(type, searchParams[type]),
      isBorder: true,
      readOnly: true,
      key: Key(type),
      labelText: type.tr(),
      onTap: () => _onSelect(type, searchParams[type],
          fnWhere: fnWhere, afterChange: afterChange),
      suffixIcon: Icon(Icons.keyboard_arrow_down),
    );
  }
}
