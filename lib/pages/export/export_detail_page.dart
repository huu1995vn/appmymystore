// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/utilities/extensions.dart';

class ExportDetailPage extends StatefulWidget {
  final int? id;
  final ExportModel? item;
  const ExportDetailPage({super.key, this.id, this.item});

  @override
  State<ExportDetailPage> createState() => _ExportDetailPageState();
}

class _ExportDetailPageState extends State<ExportDetailPage> {
  final List<ProductModel>? listData = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  ExportModel? data;
  loadData() async {
    // try {
    //   if (widget.item != null) {
    //     setState(() {
    //       data = widget.item;
    //     });
    //   } else {
    //     ResponseModel res =
    //         await DaiLyXeApiBLL_APIUser().advertbyid(widget.id!);
    //     if (res.status > 0) {
    //       setState(() {
    //         data = ExportModel.fromJson(res.data);
    //       });
    //     } else {
    //       CommonMethods.showToast(res.message);
    //     }
    //   }
    // } catch (e) {
    //   CommonMethods.showDialogError(context, e.toString());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  centerTitle: true,
                  title: MMText(
                    data: data!.name,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: CommonConstants.kDefaultMargin),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(
                            CommonConstants.kDefaultPadding),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MMText(
                                  data: "Chi tiêt",
                                  style: CommonConstants.kTextTitleStyle.bold),
                            ]),
                      )),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
