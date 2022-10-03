// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, prefer_is_empty, unused_field

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/delegates/rx_select.delegate.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> searchParams = {};
  Map<String, dynamic> names = {};
  RangeValues _currentRangeValues = const RangeValues(0, 100);
  TextStyle styleTitle =
      kTextHeaderStyle.copyWith(fontSize: 15, fontWeight: FontWeight.normal);
  @override
  initState() {
    super.initState();
    setState(() {
      searchParams = Map<String, dynamic>.from(widget.searchParams);
      _currentRangeValues = price;
    });
  }

  RangeValues get price {
    List<double> prices = [];
    try {
      prices = (searchParams["Price"] ?? "")
          .toString()
          .split(",")
          .map((s) => double.parse(s))
          .toList();
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
    double start = 0;
    double end = 100;
    if (prices.length > 0) {
      start = prices[0];
      if (prices.length == 2) {
        end = prices[1];
      }
    }
    if (start > end) {
      double tam = start;
      start = end;
      end = tam;
    }
    if (end > 100 || start < 0) {
      start = 0;
      end = 100;
    }
    return RangeValues(start, end);
  }

  set price(RangeValues value) {
    int start = value.start.round();
    int end = value.end.round();
    if (start == 0 && end == 100 && searchParams.containsKey("Price")) {
      searchParams.remove("Price");
    } else {
      searchParams["Price"] = "$start,$end";
    }
    setState(() {
      _currentRangeValues = value;
    });
  }

  _onDone() {
    CommonNavigates.goBack(context, searchParams);
  }

  _onSelect(String key, String type, int id,
      {bool Function(dynamic)? fnWhere, Function()? afterChange}) async {
    List data = MasterDataService.data[type];
    if (fnWhere != null) {
      data = data.where(fnWhere).toList();
    }
    var res = await showSearch(
        context: context, delegate: RxSelectDelegate(data: data, value: id));
    if (res != null) {
      setState(() {
        searchParams[key] = res;
        if (afterChange != null) afterChange();
      });
    }
  }

  onCancel() {
    setState(() {
      searchParams = {};
      _currentRangeValues = const RangeValues(0, 100);
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("filter".tr()),
          elevation: 0.0,
          actions: <Widget>[
            GestureDetector(
                onTap: onCancel,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Center(
                    child: Text(
                      "cancelfilter".tr(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _header("youwant".tr()),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(
                      MasterDataService.data["producttype"],
                      (index, item) {
                        return _radioButton(
                            "ProductTypeId", item["name"], item["id"]);
                      },
                    ).toList()),
              ),
              _header("generalinfor".tr()),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _selectInput("BrandId", "brand", title: "brand".tr()),
                    _selectInput("CityId", "city", title: "Vị trí"),
                    _selectInput("OrderBy", "sort", title: "Sắp xếp"),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: kDefaultPadding, left: kDefaultPadding * 1.5),
                      child: Row(
                        children: [
                          Text("Giá từ "),
                          Text(
                              CommonMethods.formatNumber(
                                  (_currentRangeValues.start * kStepPrice)
                                      .round()),
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(' đến '),
                          Text(
                              CommonMethods.formatNumber(
                                      (_currentRangeValues.end * kStepPrice)
                                          .round()) +
                                  (_currentRangeValues.end == 100 ? "+" : ""),
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    RangeSlider(
                      values: _currentRangeValues,
                      max: 100,
                      divisions: 100,
                      onChanged: (RangeValues values) {
                        setState(() {
                          price = values;
                        });
                      },
                    ),
                  ],
                ),
              ),
              _header("specifications".tr()),
              Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      _selectInput("State", "productstate",
                          title: "Tình trạng"),
                      _selectInput("FuelTypeId", "fueltype",
                          title: "Nhiên liệu"),
                      _selectInput("MadeInId", "madein", title: "Năm sản xuất"),
                      _selectInput("ColorId", "color", title: "Màu sắc"),
                      _selectInput("Door", "productdoor", title: "Số cửa"),
                      _selectInput("Seat", "productseat", title: "Số chỗ"),
                      ListTile(
                        title: Text('year'.tr(), style: kTextTitleStyle),
                        subtitle: RxInput(
                          keyboardType: TextInputType.number,
                          searchParams["Year"]?.toString() ?? "",
                          onChanged: (v) {
                            setState(() {
                              searchParams["Year"] =
                                  CommonMethods.convertToInt32(v);
                            });
                          },
                          hintText: "year".tr(),
                          style: const TextStyle(color: AppColors.black50)
                              .size(13),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        )),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                child: RxPrimaryButton(
                  onTap: _onDone,
                  text: "apply".tr(),
                ),
              )
            ],
          )
        ]);
  }

  Widget _header(String header) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Text(
        header.toUpperCase(),
        style: TextStyle().bold,
      ),
    );
  }

  Widget _radioButton(String type, String text, int value) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: (SizeConfig.screenWidth - 30) / 2,
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              searchParams[type] = value;
            });
          },
          child: Text(
            text,
            style: TextStyle(
              color: (searchParams[type] == value)
                  ? AppColors.primary
                  : AppColors.black,
            ),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: (searchParams[type] == value)
                      ? AppColors.primary
                      : AppColors.black,
                ))),
          ),
        ));
  }

  Widget _selectInput(
    String key,
    String type, {
    String? title,
    String? hintText,
    bool Function(dynamic)? fnWhere,
    dynamic Function()? afterChange,
  }) {
    var name = CommonMethods.getNameMasterById(type, searchParams[key]);
    return ListTile(
      title: Text(
        title ?? type.tr(),
        style: styleTitle,
      ),
      subtitle: Text(
          name != null && name.length > 0
              ? name
              : (hintText ?? "choose.text".tr()),
          style: TextStyle(
              color:
                  name != null && name.length > 0 ? AppColors.primary : null)),
      onTap: () => _onSelect(key, type, searchParams[key],
          fnWhere: fnWhere, afterChange: afterChange),
      trailing: Icon(AppIcons.chevron_right),
    );
  }
}
