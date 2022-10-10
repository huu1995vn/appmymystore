// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
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
                res.data ?? [], (val) => VehicleContactModel.fromJson(val));

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

  _onDelete(index) async {
    if (listData != null && listData!.isNotEmpty) {
      try {
        ResponseModel res = await DaiLyXeApiBLL_APIUser()
            .vehiclecontactdelete([listData![index].id]);
        if (res.status > 0) {
          setState(() {
            listData!.removeAt(index);
          });
          CommonMethods.showToast("success".tr);
        } else {
          CommonMethods.showToast(res.message);
        }
        //Call api gọi api xóa
      } catch (e) {
        CommonMethods.showDialogError(context, e);
      }
    }
  }

  // _onDeleteAll() async {
  //   if (listData != null && listData!.isNotEmpty) {
  //     var res =
  //         await CommonMethods.showConfirmDialog(context, "message.alert01".tr);
  //     if (!res) return;
  //     try {
  //       List<int> ids = listData!.map((e) => e.id).toList();
  //       ResponseModel res =
  //           await DaiLyXeApiBLL_APIUser().vehiclecontactdelete(ids);
  //       if (res.status > 0) {
  //         CommonMethods.showToast("success".tr);
  //         loadData();
  //       } else {
  //         CommonMethods.showToast(res.message);
  //       }
  //       //Call api gọi api xóa
  //     } catch (e) {
  //       CommonMethods.showDialogError(context, e);
  //     }
  //   }
  // }

  // _onSeen() async {
  //   if (listData != null && listData!.isNotEmpty) {
  //     try {
  //       List<int> ids = listData!.map((e) => e.id).toList();
  //       ResponseModel res =
  //           await DaiLyXeApiBLL_APIUser().vehiclecontactready(ids);
  //       if (res.status > 0) {
  //         CommonMethods.showToast("success".tr);
  //         loadData();
  //       } else {
  //         CommonMethods.showToast(res.message);
  //       }
  //       //Call api gọi api xóa
  //     } catch (e) {
  //       CommonMethods.showDialogError(context, e);
  //     }
  //   }
  // }

  @override
  dispose() {
    super.dispose();
    if (mounted) scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('contact'.tr),
          elevation: 0.0,
        ),
        key: _key,
        body: RxCustomScrollView(
          key: const Key("LVehicleContact"),
          controller: scrollController,
          onNextScroll: onNextPage,
          onRefresh: onRefresh,
          slivers: <Widget>[
            RxSliverList(listData, (BuildContext context, int index) {
              var item = listData![index];
              return ItemVehicleContactWidget(listData![index],
                  onTap: () {
                        CommonNavigates.toVehicleContactPage(context,
                            id: item.id);
                        setState(() {
                          item.status = 2;
                        });
                      },
                  onDelete: (c) => {_onDelete(index)});
            })
          ],
        ));
  }
}
