// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/rao/vehiclecontact/widgets/item_vehiclecontact.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class VehicleContactPage extends StatefulWidget {
  const VehicleContactPage({Key? key}) : super(key: key);

  @override
  State<VehicleContactPage> createState() => _VehicleContactPageState();
}

class _VehicleContactPageState extends State<VehicleContactPage> {
  @override
  void initState() {
    super.initState();
    loadData(paging);
  }

  int paging = 1;
  int totalItems = 0;
  List<VehicleContactModel>? listData;
  AutoScrollController scrollController = AutoScrollController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  loadData([nPaging = 1]) async {
    if (nPaging > 1 && listData != null && totalItems <= listData!.length) {
      return;
    }

    try {
      nPaging = nPaging ?? 1;
      Map<String, dynamic> params = {"p": nPaging, "n": kItemOnPage};
      ResponseModel res = await DaiLyXeApiBLL_APIUser().vehiclecontact(params);
      if (res.status > 0) {
        List<VehicleContactModel> list =
            CommonMethods.convertToList<VehicleContactModel>(
                res.data, (val) => VehicleContactModel.fromJson(val));
        setState(() {
          if (nPaging == 1 && (list.isEmpty)) {
            totalItems = 0;
          }
          if (list.isNotEmpty) {
            totalItems = list[0].rxtotalrow;
          }
          listData ??= [];
          if (nPaging == 1) {
            listData = list;
          } else {
            listData = (listData! + list);
          }
        });
        paging = nPaging;
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  Future<dynamic> onRefresh() async {
    return await loadData();
  }

  @override
  dispose() {
    super.dispose();
    if (mounted) scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        key: _key,
        body: RxCustomScrollView(
          appBar: SliverAppBar( 
            centerTitle: true,
            title: Text('contact'.tr()),
            elevation: 0.0, 
          ),
          key: const Key("LVehicleContact"),
          controller: scrollController,
          onNextScroll: onNextPage,
          onRefresh: onRefresh,
          slivers: <Widget>[
            RxSliverList(listData, (BuildContext context, int index) {
              return ItemVehicleContactWidget(listData![index]);
            })
          ],
        ));
  }
}
