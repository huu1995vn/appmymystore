// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, prefer_is_empty, unused_field

import 'package:get/get.dart';
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
    Map<String, dynamic> dataParams = <String, dynamic>{};
    searchParams.forEach((key, value) {
      if (value != null && value != -1) {
        dataParams[key] = value;
      }
    });
    CommonNavigates.goBack(context, dataParams);
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
          title: Text("filter".tr),
          elevation: 0.0,
          actions: <Widget>[
            GestureDetector(
                onTap: onCancel,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPaddingBox),
                  child: Center(
                    child: Text(
                      "cancelfilter".tr,
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
              _header("youwant".tr),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
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
              ),
              _header("info.general".tr),
              Card(
                child: Column(
                  children: [
                    rxSelectInput(
                        context, "brand", searchParams["BrandId"] ?? -1,
                        title: Text("brand".tr), afterChange: (v) {
                      setState(() {
                        searchParams["BrandId"] = v;
                      });
                    }),
                    rxSelectInput(context, "city", searchParams["CityId"] ?? -1,
                        title: Text("city".tr), afterChange: (v) {
                      setState(() {
                        searchParams["CityId"] = v;
                      });
                    }),
                    rxSelectInput(
                        context, "sort", searchParams["OrderBy"] ?? -1,
                        title: Text("sort".tr), afterChange: (v) {
                      setState(() {
                        searchParams["OrderBy"] = v;
                      });
                    }),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: kDefaultPadding, left: kDefaultPaddingBox),
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
                      inactiveColor: Colors.grey,
                      activeColor: Colors.lightBlueAccent,
                      onChanged: (RangeValues values) {
                        setState(() {
                          price = values;
                        });
                      },
                    ),
                  ],
                ),
              ),
              _header("specifications".tr),
              Card(
                  // color: Colors.white,
                  child: Column(
                children: [
                  rxSelectInput(
                      context, "productstate", searchParams["State"] ?? -1,
                      title: Text("state".tr), afterChange: (v) {
                    setState(() {
                      searchParams["State"] = v;
                    });
                  }),
                  rxSelectInput(
                      context, "fueltype", searchParams["FuelTypeId"] ?? -1,
                      title: Text("fueltype".tr), afterChange: (v) {
                    setState(() {
                      searchParams["FuelTypeId"] = v;
                    });
                  }),
                  rxSelectInput(
                      context, "madein", searchParams["MadeInId"] ?? -1,
                      title: Text("madein".tr), afterChange: (v) {
                    setState(() {
                      searchParams["MadeInId"] = v;
                    });
                  }),
                  rxSelectInput(context, "color", searchParams["ColorId"] ?? -1,
                      title: Text("color".tr), afterChange: (v) {
                    setState(() {
                      searchParams["ColorId"] = v;
                    });
                  }),
                  rxSelectInput(
                      context, "productdoor", searchParams["ColorId"] ?? -1,
                      title: Text("door".tr), afterChange: (v) {
                    setState(() {
                      searchParams["Door"] = v;
                    });
                  }),
                  rxSelectInput(
                      context, "productseat", searchParams["Seat"] ?? -1,
                      title: Text("seat".tr), afterChange: (v) {
                    setState(() {
                      searchParams["Seat"] = v;
                    });
                  }),
                  rxSelectInput(context, "year", searchParams["Year"] ?? -1,
                      title: Text("year".tr), afterChange: (v) {
                    setState(() {
                      searchParams["Year"] = v;
                    });
                  }),
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
                  text: "apply".tr,
                ),
              )
            ],
          )
        ]);
  }

  Widget _header(String header) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPaddingBox),
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return (searchParams[type] == value)
                  ? AppColors.primary
                  : AppColors.white;
            }),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: (searchParams[type] == value)
                      ? AppColors.primary
                      : AppColors.black,
                ))),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: (searchParams[type] == value)
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
        ));
  }

  
}
