// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/entities.dart';
import 'package:http/http.dart' as http;
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'dart:async';

import 'package:raoxe/core/utilities/extensions.dart';

class RxSearchDelegate extends SearchDelegate<dynamic> {
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
  RxSearchDelegate();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
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

    return query == null || query.length == 0
        ? Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Wrap(
              children: List<Widget>.generate(
                listHotSearch.length,
                (int index) {
                  return Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 5),
                      child: ChoiceChip(
                          label: Text(listHotSearch[index]),
                          selected: false,
                          selectedColor: Colors.red[300],
                          padding: const EdgeInsets.all(13),
                          onSelected: (bool selected) {}));
                },
              ).toList(),
            ),
          )
        : FutureBuilder<List<SuggestionModel>>(
            future: _completer.future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      SuggestionModel item = suggestionList[index];
                      return ListTile(
                        leading: Icon(
                          item.isLocal ? Icons.history : Icons.search,
                          size: 19,
                        ),
                        title: GestureDetector(
                          onTap: () {
                            _addSuggest(item.text, setState);
                            close(context, item);
                          },
                          child: Text(item.text),
                        ),
                        trailing: item.isLocal
                            ? GestureDetector(
                                onTap: () {
                                  _deleteSuggest(item.text, setState);
                                },
                                child: Icon(Icons.close, size: 19))
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
          );
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

  _addSuggest(value, StateSetter setState) {
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
    if (suggestionList.length < kItemOnPage) {
      List list = [];
      try {
        if (RxSearchDelegate.cacheapiSearch[query] == null ||
            RxSearchDelegate.cacheapiSearch[query].length == 0) {
          final queryParameters = <String, String>{};
          final uri = Uri.parse("https://dailyxe.com.vn/api/suggest");
          Map<String, String>? headers = {
            'Authorization':
                'DVeVJULNIK1AuR-7f1hfMEXi0jNyO6JF1kNnBXkKvtVvF5pWegmeSGWlDdHnjgq0',
            'referer': 'https://dailyxe.com.vn',
            "Content-Type": "application/json"
          };

          var body = json.encode({"device": "1", "s": query, "n": kItemOnPage});

          final result = await http.post(uri, body: body, headers: headers);
          final data = jsonDecode(result.body)["data"] as List;

          list = data.length > 0
              ? data.map((e) => jsonDecode(e["Data"])["TuKhoa"]).toList()
              : [];
          if (list.length > 0) {
            RxSearchDelegate.cacheapiSearch[query] = list;
          }
        } else {
          list = RxSearchDelegate.cacheapiSearch[query];
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
