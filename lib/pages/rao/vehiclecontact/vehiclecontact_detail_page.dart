// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/constants.dart';

class VehicleContactDetailPage extends StatefulWidget {
  final int? id;
  final VehicleContactModel? item;

  const VehicleContactDetailPage({super.key, this.id, this.item});

  @override
  State<VehicleContactDetailPage> createState() =>
      _VehicleContactDetailPageState();
}

class _VehicleContactDetailPageState extends State<VehicleContactDetailPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  VehicleContactModel? data;
  loadData() async {
    try {
      if (widget.item != null) {
        setState(() {
          data = widget.item;
        });
      } else {
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().vehiclecontactbyid(widget.id!);
        if (res.status > 0) {
          setState(() {
            data = VehicleContactModel.fromJson(res.data);
          });
        } else {
          CommonMethods.showToast(res.message);
        }
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết quảng cáo',
          style: kTextHeaderStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: RxWrapper(
        body: Column(
          children: [Text("VehicleContact-detail ${widget.item!.name}")],
        ),
      ),
    );
  }
}
