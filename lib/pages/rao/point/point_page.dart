// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/data/historypoints.dart';
import 'package:raoxe/pages/rao/point/widgets/card_point.wdiget.dart';
import 'package:raoxe/pages/rao/point/widgets/history_point.widget.dart';

class PointPage extends StatefulWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  @override
  dispose() {
    super.dispose();
  }

  int currentIndex = 1;
  DateTime today = DateTime(
    2021,
    11,
    25,
    12,
  );

  //! fake today - only for debug, use DateTime.now() instead.
  //TODO change fake today to DateTime.now()
  int _sortValue = 0;

  int _cardIndex = 0;

  bool _bottomNavBarVisible = true;
  int _transferIndex = 0;
  String _nameRankType = "Member";
  int _cardNumberTransfer = 7065447803090891;
  int _balanceTransfer = 0;
  Color _bgColorTransfer = Colors.white;
  Color _fontColorTransfer = Colors.black;

  bool _isGoUpVisible = false;
  final ScrollController _lvController = ScrollController();
  final int _lvDefaultMax = 10;
  int _lvCurrentMax = 10;
  List<HistoryPoint> _filtredHistoryPoints = [];
  List<HistoryPoint> _historyPoints = [];
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _ammountController = TextEditingController();
  final _ibanGlobalKey = GlobalKey<FormState>();
  final _ammountGlobalKey = GlobalKey<FormState>();
  PointModel data = PointModel(1000, 0, 1, 1000);
  @override
  void initState() {
    super.initState();
    _lvController.addListener(listenScrolling);
  }

  _getMoreHistoryPoints() {
    for (int i = _lvCurrentMax;
        i < _lvCurrentMax + _lvDefaultMax && i < _filtredHistoryPoints.length;
        i++) {
      _historyPoints.add(_filtredHistoryPoints[i]);
    }
    _lvCurrentMax = _lvCurrentMax + _lvDefaultMax;
    setState(() {});
  }

  void listenScrolling() {
    if (_lvController.position.pixels ==
        _lvController.position.maxScrollExtent) {
      _getMoreHistoryPoints();
    }
    if (_lvController.position.pixels > 500 && _isGoUpVisible == false) {
      setState(() {
        _isGoUpVisible = true;
      });
    } else if (_lvController.position.pixels < 500 && _isGoUpVisible == true) {
      setState(() {
        _isGoUpVisible = false;
      });
    }
  }

  void _bottomBarVisibility(
    bool enabled,
    String name,
    int id,
    int point,
    Color bgColor,
    Color fontColor,
  ) {
    setState(() {
      _bottomNavBarVisible = enabled;
      _nameRankType = name;
      _cardNumberTransfer = id;
      _balanceTransfer = point;
      _bgColorTransfer = bgColor;
      _fontColorTransfer = fontColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_bottomNavBarVisible == true) {
      _onFilter();
    }
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.black, //change your color here
        ),
        centerTitle: true,
        title: Text('Point',
            style: kTextHeaderStyle.copyWith(color: AppColors.black)),
        backgroundColor: AppColors.grey,
        elevation: 0.0,
      ),
      key: const Key("LPoint"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Stack(
            children: [
              ListView(
                controller: _lvController,
                children: <Widget>[
                  CardPointBuild(
                    data: data,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'POINT HISTORY',
                        style: kTextTitleStyle.bold,
                      ),
                      DropdownButtonHideUnderline(
                          // build filter options
                          child: DropdownButton(
                            value: _sortValue,
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  "Today",
                                  style: kTextSubTitleStyle,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text(
                                  "Yesterday",
                                  style: kTextSubTitleStyle,
                                ),
                              ),
                              DropdownMenuItem(
                                  value: 2,
                                  child: Text(
                                    "Last 7 days",
                                  style: kTextSubTitleStyle,
                                  )),
                              DropdownMenuItem(
                                value: 3,
                                child: Text(
                                  "Last 30 days",
                                  style: kTextSubTitleStyle,
                                ),
                              ),
                            ],
                            onChanged: (int? value) {
                              setState(
                                () {
                                  _sortValue = value!;
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                  Card(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _historyPoints.isNotEmpty
                          ? _historyPoints.length < _filtredHistoryPoints.length
                              ? _historyPoints.length + 1
                              : _historyPoints.length
                          : 1,
                      itemBuilder: (BuildContext ctxt, int index) {
                        if (index == _historyPoints.length &&
                            index < _filtredHistoryPoints.length) {
                          return Center(
                            child: Container(
                              height: size.height * 0.1,
                              width: size.width * 0.2,
                              margin: const EdgeInsets.all(5),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                          );
                        } else {
                          // build rHistoryPoints
                          return _historyPoints.isNotEmpty
                              ? buildHistoryPoint(
                                  _historyPoints[index].eventName,
                                  _historyPoints[index].ammountChange,
                                  _historyPoints[index].income,
                                  _historyPoints[index].date,
                                  size,
                                )
                              : Align(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.01,
                                      left: size.width * 0.05,
                                      right: size.width * 0.05,
                                    ),
                                    child: Column(children: [
                                      Text(
                                        "Woops! \n We couldn't find anything with this filter",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: size.height * 0.02,
                                        ),
                                      ),
                                      const Divider(),
                                    ]),
                                  ),
                                );
                        }
                      },
                    ),
                  ),
                ],
              ),
             ],
          ),
        ),
      ),
    );
  }

  void _onFilter() {
    _historyPoints = [];

    //TODO add max value for sort and connect rHistoryPoints to database

    rHistoryPoints.sort((b, a) => a.date.compareTo(b.date));
    if (_sortValue == 0) {
      _filtredHistoryPoints = rHistoryPoints
          .toList()
          .where((e) =>
              (today.day ==
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(e.date),
                      ).day &&
                  today.month ==
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(e.date),
                      ).month) &&
              today.year ==
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(e.date),
                  ).year)
          .toList();
    }
    if (_sortValue == 1) {
      _filtredHistoryPoints = rHistoryPoints
          .toList()
          .where((e) =>
              (today.day - 1 ==
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(e.date),
                      ).day &&
                  today.month ==
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(e.date),
                      ).month) &&
              today.year ==
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(e.date),
                  ).year)
          .toList();
    }
    if (_sortValue == 2) {
      _filtredHistoryPoints = rHistoryPoints
          .toList()
          .where((e) =>
              (today.day - 7 <=
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(e.date),
                      ).day &&
                  today.month ==
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(e.date),
                      ).month) &&
              today.year ==
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(e.date),
                  ).year)
          .toList();
    }
    if (_sortValue == 3) {
      _filtredHistoryPoints = rHistoryPoints
          .toList()
          .where((e) =>
              (today.day - 30 <=
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(e.date),
                      ).day &&
                  today.month ==
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(e.date),
                      ).month) &&
              today.year ==
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(e.date),
                  ).year)
          .toList();
    }

    for (int i = 0;
        i < _lvCurrentMax && i < _filtredHistoryPoints.length;
        i++) {
      _historyPoints.add(_filtredHistoryPoints[i]);
    }
  }
}

