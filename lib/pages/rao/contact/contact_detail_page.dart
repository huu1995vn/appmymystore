// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/theme_provider.dart';
import 'package:raoxe/core/utilities/constants.dart';

class ContactDetailPage extends StatefulWidget {
  final int? id;
  final ContactModel? item;

  const ContactDetailPage({super.key, this.id, this.item});

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  ContactModel? data;
  loadData() async {
    try {
      if (widget.item != null) {
        setState(() {
          data = widget.item;
        });
      } else {
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().advertdetail(widget.id!);
        if (res.status > 0) {
          List<dynamic> ldata = jsonDecode(res.data);
          setState(() {
            data = ContactModel.fromJson(ldata[0]);
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
    final theme = Provider.of<ThemeProvider>(context);
    return RxScaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết liên hệ',
          style: TextStyle(
            color: kWhite,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      child: RxWrapper(
        body: Column(
          children: [Text("advert-detail ${widget.item!.fullname}")],
        ),
      ),
    );
  }
}
