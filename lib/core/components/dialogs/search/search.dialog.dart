// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class SearchDialog extends StatefulWidget {
  SearchDialog({super.key});
  @override
  State<SearchDialog> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchDialog> {
  static Map<String, List<String>> cacheListSearchApi =
      <String, List<String>>{};
  String textSearch = "";
  final List<String> listHotSearch = CommonConfig.hotSearch.split(",");
  List<String> listSearchLocal =
      (StorageService.get(StorageKeys.text_search)??"")!.split(",");
  List<TextSearchModel>? listSearch;
  final int _value = -1;
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: textSearch == null || textSearch.isEmpty
                ? Column(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Hot".tr(),
                            style: const TextStyle().bold,
                          )),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Wrap(
                            children: List<Widget>.generate(
                              listHotSearch.length,
                              (int index) {
                                return Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, bottom: 5),
                                    child: ChoiceChip(
                                        label: Text(listHotSearch[index]),
                                        selected: _value == index,
                                        selectedColor: Colors.red[300],
                                        padding: const EdgeInsets.all(13),
                                        onSelected: (bool selected) {
                                         
                                        }));
                              },
                            ).toList(),
                          )),
                      if (listHotSearch != null && listHotSearch.isNotEmpty)
                        Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "history.text".tr(),
                                    style: const TextStyle().bold,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _onDeleteAll();
                                      },
                                      child: Text("delete.history".tr(),
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontStyle: FontStyle.italic)))
                                ])),
                      Expanded(child: _bodylist())
                    ],
                  )
                : _bodylist()));
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize:
          Size(SizeConfig.screenWidth, AppBar().preferredSize.height + 80),
      child: Stack(
        children: <Widget>[
          Container(
              // color: AppColors.primary,
              decoration: kBoxDecorationStyle,
              height: AppBar().preferredSize.height + 75,
              width: SizeConfig.screenWidth,
              child: AppBar(centerTitle: true, elevation: 0.0)),

          Container(), // Required some widget in between to float AppBar
          Positioned(
            // To take AppBar Size only
            top: 100.0,
            left: 20.0,
            right: 20.0,
            child: 
            AppBar(
              
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.home, color: AppColors.primary),
                onPressed: () {},
              ),
              primary: false,
              title: TextField(
                  style: const TextStyle().textColor(Colors.black),
                  decoration: const InputDecoration(
                     
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: (value) {
                    textSearch = value;
                    _onChanged();
                  },
                  onSubmitted: (value) {
                    
                  }),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search, color: AppColors.primary),
                  onPressed: () {
                    _onSearch();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bodylist() {
    return Container(
      child: RxListView(listSearch, _listBuilder,
          awaiting: RxCardSkeleton(barCount: 1, isShowAvatar: false)),
    );
  }

  Widget _listBuilder(BuildContext context, int index) {
    TextSearchModel item = listSearch![index];
    return ListTile(
      onTap: () {
      },
      leading: Icon(Icons
          .search), //item["type"] == 0 ? Icon(Icons.history) : Icon(Icons.search),
      title: Text(item.text),
      
    );
  }

  _onSearch() {
    textSearch = textSearch.toLowerCase();
    listSearchLocal.remove(textSearch);
    listSearchLocal = [
      ...[textSearch],
      ...listSearchLocal
    ];
    StorageService.set(StorageKeys.text_search, listSearchLocal.join(","));
    CommonNavigates.toProductPage(context, paramsSearch: {"s": textSearch});
  }

  loadData() async {
    try {
      List<TextSearchModel> list = <TextSearchModel>[];
      List<String> listSearchApi = [];
      //Dữ liệu local
      if (listSearchLocal != null && listSearchLocal.length == kItemOnPage) {
        listSearchLocal = listSearchLocal
            .where((element) => element.indexOf(textSearch) >= 0)
            .toList();
        setState(() {
          list = listSearchLocal
              .map((element) => TextSearchModel(text: element, isLocal: true))
              .toList();
        });
        return;
      }
      //Dữ liệu api
      if (cacheListSearchApi[textSearch] != null) {
        listSearchApi = cacheListSearchApi[textSearch] ?? [];
      } else {
        try {
          // ResponseModel res =
          //     await DaiLyXeApiBLL_APIGets().getSuggest(textSearch);
          // if (res.status > 0) {
          //   if (res.data != null) {
          //     listSearchApi = (res.data as List<Map>)
          //         .map((e) =>
          //             jsonDecode(e["Data"])["TuKhoa"].toString().toLowerCase())
          //         .toList();
          //     if (listSearch!.isNotEmpty) {
          //       cacheListSearchApi[textSearch] = listSearchApi!;
          //     }
          //   }
          // } else {
          //   listSearchApi = [];
          //   CommonMethods.showToast(res.message);
          // }
          listSearchApi = ["xe", "mazda"];
        } catch (e) {
          CommonMethods.showToast(e.toString());
        }
      }
      //me
      if (listSearchApi.isNotEmpty) {
        list.addAll(listSearchApi!
            .map((element) => TextSearchModel(text: element, isLocal: true)).toList());
      }
      setState(() {
        if (list.isNotEmpty) {
          listSearch = list.sublist(
              0, (list.length >= kItemOnPage ? kItemOnPage : list.length));
        } else {
          listSearch = [];
        }
      });
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }

  _onChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  _onDeleteAll() {
    listSearchLocal = [];
    StorageService.set(StorageKeys.text_search, listSearchLocal.join(","));
    setState(() {
      listSearch = [];
    });
  }

  _onDelete(int index) {
    String txtSearch = listSearch![index].text;
    txtSearch = txtSearch.toLowerCase();
    listSearchLocal.remove(txtSearch);
    StorageService.set(StorageKeys.text_search, listSearchLocal.join(","));
    setState(() {
      listSearch!.removeAt(index);
    });
  }
}
