// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_configs.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/services/storage/storage_service.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'dart:async';
import 'package:mymystore/core/utilities/extensions.dart';
import 'package:mymystore/core/utilities/size_config.dart';

import '../../utilities/app_colors.dart';

class MMSearchDelegate extends SearchDelegate<dynamic> {
  static Map cacheapiSearch = {};
  Completer<List<SuggestionModel>> _completer = Completer();

  late final Debouncer _debouncer = Debouncer(Duration(milliseconds: 300),
      initialValue: '', onChanged: (value) {
    try {
      _completer.complete(_fetchSuggestions()); // call the API endpoint
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
  });

  final List<String> listHotSearch = CommonConfig.hotSearch.split(",");
  List<String> listSearchLocal =
      (StorageService.get(StorageKeys.text_search) ?? "")!.split(",");
  List<SuggestionModel> suggestionList = <SuggestionModel>[];
  MMSearchDelegate();
  @override
  String get searchFieldLabel => 'text.search'.tr;
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
    _debouncer.value = query; // update the _debouncer
    _completer =
        Completer(); // re-create the _completer, 'cause old one might be completed already

    return Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.all(CommonConstants.kDefaultPaddingBox),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: CommonConstants.kDefaultPaddingBox),
                child: Text("Được tìm nhiều")),
            query == null || query.isEmpty
                ? Wrap(
                    children: List<Widget>.generate(
                      listHotSearch.length,
                      (int index) {
                        return Card(
                            margin:
                                const EdgeInsets.only(right: 10, bottom: 10),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Get.isDarkMode
                                      ? AppColors.blackLight
                                      : AppColors.black50,
                                  width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  {
                                    _addSuggest(listHotSearch[index]);
                                    close(context, listHotSearch[index]);
                                  }
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(
                                        CommonConstants.kDefaultPaddingBox),
                                    child: Text(listHotSearch[index]))));
                      },
                    ).toList(),
                  )
                : FutureBuilder<List<SuggestionModel>>(
                    future: _completer.future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              SuggestionModel item = suggestionList[index];
                              return ListTile(
                                leading: Icon(
                                  item.isLocal
                                      ? AppIcons.history
                                      : AppIcons.magnifier,
                                  size: 19,
                                ),
                                title: GestureDetector(
                                  onTap: () {
                                    _addSuggest(item.text);
                                    close(context, item.text);
                                  },
                                  child: Text(item.text),
                                ),
                                trailing: item.isLocal
                                    ? GestureDetector(
                                        onTap: () {
                                          _deleteSuggest(item.text, setState);
                                        },
                                        child: Icon(AppIcons.cross, size: 19))
                                    : null,
                              );
                            },
                            itemCount: suggestionList.length,
                          );
                        });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
          ],
        ));
  }

  _deleteSuggest(value, StateSetter setState) {
    if (listSearchLocal.contains(value)) listSearchLocal.remove(value);
    var index = suggestionList.indexWhere((element) => element.text == value);
    if (index >= 0) {
      setState(() {
        suggestionList.removeAt(index);
      });
    }
    StorageService.set(StorageKeys.text_search, listSearchLocal.join(","));
  }

  _addSuggest(value) {
    listSearchLocal.remove(value);
    listSearchLocal = List.from([value])..addAll(listSearchLocal);
    StorageService.set(StorageKeys.text_search, listSearchLocal.join(","));
  }

  Future<List<SuggestionModel>> _fetchSuggestions() async {
    suggestionList = listSearchLocal
        .where((element) => element.toString().toLowerCase().startsWith(query))
        .toList()
        .map((e) => SuggestionModel(text: e, isLocal: true))
        .toList();
    if (suggestionList.length < CommonConstants.kItemOnPage) {
      List list = [];
      try {
        if (MMSearchDelegate.cacheapiSearch[query] == null ||
            MMSearchDelegate.cacheapiSearch[query].length == 0) {
          // var res = await ApiBLL_APIGets().suggest(query);
          // if (res.status > 0) {
          //   final data = res.data as List;
          //   list = data.isNotEmpty
          //       ? data.map((e) => jsonDecode(e["Data"])["TuKhoa"]).toList()
          //       : [];
          //   if (list.isNotEmpty) {
          //     MMSearchDelegate.cacheapiSearch[query] = list;
          //   }
          // }
        } else {
          list = MMSearchDelegate.cacheapiSearch[query];
        }

        suggestionList.addAll(
            list.map((e) => SuggestionModel(text: e, isLocal: false)).toList());
        suggestionList = suggestionList.unique((x) => x.text);
        return suggestionList;
      } catch (e) {
        CommonMethods.wirtePrint(e);
      }
    }
    return suggestionList;
  }
}
