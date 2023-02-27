// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/components/mm_image.dart';
import 'package:mymystore/core/components/mm_input.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/utilities/extensions.dart';

class ProductDetailPage extends StatefulWidget {
  final int? id;
  final ProductModel? item;

  const ProductDetailPage({super.key, this.id, this.item});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  ProductModel? data;
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
    //         data = ProductModel.fromJson(res.data);
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
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        MMListTile(
                          title: MMText(data: "Tên sản phẩm"),
                          leading: MMInput(
                            data!.name,
                            hintText: "Nhập tên sản phẩm".tr,
                            icon: const Icon(AppIcons.phone_1),
                            keyboardType: TextInputType.number,
                            onChanged: (v) => {data!.name = v},
                          ),
                        ),
                        MMListTile(
                          title: MMText(data: "Loại sản phẩm"),
                          leading: MMInput(
                            data!.name,
                            hintText: "Loại sản phẩm".tr,
                            icon: const Icon(AppIcons.phone_1),
                            keyboardType: TextInputType.number,
                            onChanged: (v) => {data!.name = v},
                          ),
                        ),
                        MMListTile(
                          title: MMText(data: "Chất liệu"),
                          leading: MMInput(
                            data!.name,
                            hintText: "Chất liệu".tr,
                            icon: const Icon(AppIcons.phone_1),
                            keyboardType: TextInputType.number,
                            onChanged: (v) => {data!.name = v},
                          ),
                        ),
                        MMListTile(
                          title: MMText(data: "Hình ảnh"),
                          leading: MMImage( ""),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
