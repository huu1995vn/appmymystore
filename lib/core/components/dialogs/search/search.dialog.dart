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

class RxSearchDelegate extends SearchDelegate<dynamic> {
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
                return ListView.builder(
                  itemBuilder: (context, index) {
                    SuggestionModel item = snapshot.data![index];
                    return ListTile(
                      leading: Icon(
                        item.isLocal ? Icons.history : Icons.search,
                        size: 19,
                      ),
                      title: Text(item.text),
                      onTap: () {
                        
                        close(context, item);
                      },
                      trailing: (!item.isLocal)
                          ? null
                          : GestureDetector(
                              onTap: () {}, child: Icon(Icons.close, size: 19)),
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
  }

  Future<List<SuggestionModel>> _fetchSuggestions() async {
    final suggestionList = listSearchLocal
        .where((element) => element.toString().toLowerCase().startsWith(query))
        .toList()
        .map((e) => SuggestionModel(text: e, isLocal: true))
        .toList();
    if (suggestionList.length < kItemOnPage) {
      try {
        final queryParameters = <String, String>{};
        final uri = Uri.parse("https://dailyxe.com.vn/api/suggest");
        Map<String, String>? headers = {
          'Authorization':
              'DVeVJULNIK1AuR-7f1hfMEXi0jNyO6JF1kNnBXkKvtVvF5pWegmeSGWlDdHnjgq0',
          'referer': 'https://dailyxe.com.vn',
          "Content-Type": "application/json"
        };
        var body = json.encode({
          "device": "1",
          "s": query,
          "n": kItemOnPage - suggestionList.length
        });

        final result = await http.post(uri, body: body, headers: headers);
        final data = jsonDecode(result.body)["data"] as List;

        final list = data.length > 0
            ? data.map((e) => jsonDecode(e["Data"])["TuKhoa"]).toList()
            : [];
        suggestionList.addAll(
            list.map((e) => SuggestionModel(text: e, isLocal: false)).toList());
        return suggestionList;
      } catch (e) {
        CommonMethods.wirtePrint(e);
      }
    }
    return suggestionList;
  }
}
