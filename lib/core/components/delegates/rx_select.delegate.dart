// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
// ignore: unused_import
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/constants.dart';

class RxSelectDelegate extends SearchDelegate<dynamic> {
  List data;
  dynamic value;
  bool? ismultiple = false;
  RxSelectDelegate(
      {required this.data, required this.value, this.ismultiple}) {}
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(AppIcons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(AppIcons.arrow_left),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? data
        : data
            .where((element) =>
                element['name'].toString().toLowerCase().startsWith(query))
            .toList();

    return data == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: Theme.of(context).cardColor,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: suggestionList!.length,
                  itemBuilder: (context, index) {
                    var item = suggestionList[index];
                    return ismultiple == true
                        ? CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.trailing,
                            // selected: (value as List<int>).indexOf(item["id"])>=0,
                            value: (value as List<int>).contains(item["id"]),
                            title: Text(item["name"]),
                            onChanged: (v) {
                              setState(() {
                                if (v == true) {
                                  (value as List<int>).add(item["id"]);
                                } else {
                                  (value as List<int>).remove(item["id"]);
                                }
                              });
                            },
                          )
                        : RadioListTile(
                            toggleable: true,
                            controlAffinity: ListTileControlAffinity.trailing,
                            selected: item["id"] == value,
                            value: item["id"],
                            title: Text(item["name"]),
                            groupValue: value,
                            onChanged: (v) {
                              setState(() {
                                value = v;
                              });
                            },
                          );
                  },
                )),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: RxPrimaryButton(
                      onTap: () {
                        CommonNavigates.goBack(context, value);
                      },
                      text: "Ok"),
                )
              ]);
            }));
  }
}
