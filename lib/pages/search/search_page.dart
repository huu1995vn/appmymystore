// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_configs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class Search extends StatefulWidget {
  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late String textSearch;
  final List<String> listHotSearch = CommonConfig.hotSearch.split(",");
  late List<String> listSearch;
    final int _value = -1;

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
                            "Từ khóa HOT",
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
                                          // toPageTimKiemPage(
                                          //     context, _listTuKhoaHot[index]);
                                        }));
                              },
                            ).toList(),
                          )),
                      if (listHotSearch != null &&
                          listHotSearch.isNotEmpty)
                        Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Lịch sử ",
                                    style: const TextStyle().bold,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        // onDeleteAllHistory();
                                      },
                                      child: Text("delete.history".tr(),
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontStyle: FontStyle.italic)))
                                ])),
                      Expanded(
                          child: Container()
                          // (listHotSearch != null &&
                          //         listHotSearch.isNotEmpty)
                          //     ? DataListView(listHotSearch, _listBuilder)
                          //     : Container()
                          )
                    ],
                  )
                : Container()));//DataListView(listHotSearch, _listBuilder)));
    
  }

  PreferredSize _appBar() {
   return  PreferredSize(
      preferredSize:
          Size(SizeConfig.screenWidth, AppBar().preferredSize.height + 80),
      child: Stack(
        children: <Widget>[
          Container(
            color: AppColors.primary,
            height: AppBar().preferredSize.height + 75,
            width: SizeConfig.screenWidth,
            child: Center(
              child: Text(
                "Tìm kiếm",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),

          Container(), // Required some widget in between to float AppBar

          Positioned(
            // To take AppBar Size only
            top: 100.0,
            left: 20.0,
            right: 20.0,
            child: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.home, color: AppColors.primary),
                onPressed: () {
                  // CommonNavigates.toPageHome(context);
                },
              ),
              primary: false,
              title: TextField(
                  style: const TextStyle().textColor(Colors.black),
                  // controller: txtSearch,
                  decoration: const InputDecoration(
                      hintText: "Từ khóa tìm kiếm",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: (value) {
                    // onChangedTuKhoaTimKiem(value);
                  },
                  onSubmitted: (value) {
                    // focusNode.unfocus();
                    // toPageTimKiemPage(context, textSearch);
                  }),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search, color: AppColors.primary),
                  onPressed: () {
                    // if (txtSearch.text.isNullEmpty) {
                    //   focusNode.unfocus();
                    //   toPageTimKiemPage(context, txtSearch.text);
                    // } else {
                    //   txtSearch.clear();
                    //   onChangedTuKhoaTimKiem(txtSearch.text);
                    // }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
