// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/utilities/app_colors.dart';

class ExportDetailPage extends StatefulWidget {
  final int? id;
  final ExportModel? item;
  const ExportDetailPage({super.key, this.id, this.item});

  @override
  State<ExportDetailPage> createState() => _ExportDetailPageState();
}

class _ExportDetailPageState extends State<ExportDetailPage> {
  final List<ProductModel>? datas = [];
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text('Your Cart',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
            Text('3 items',
                style: TextStyle(
                    fontSize: 10, color: Colors.black.withOpacity(0.7))),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(AppIcons.arrow_back),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: AppColors.primarySoft,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      // Checkout Button
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.grey, width: 1))),
        child: ElevatedButton(
          onPressed: () {
            //Navigator.of(context).push(
                // MaterialPageRoute(builder: (context) => OrderSuccessPage()));
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
            backgroundColor: AppColors.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 6,
                child: Text(
                  'Checkout',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'poppins'),
                ),
              ),
              Container(
                width: 2,
                height: 26,
                color: Colors.white.withOpacity(0.5),
              ),
              Flexible(
                flex: 6,
                child: Text(
                  'Rp 10,429,000',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return MMCartTile(
                data: datas![index],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemCount: 3,
          ),
          // Section 2 - Shipping Information
          Container(
            margin: EdgeInsets.only(top: 24),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.grey, width: 1),
            ),
            child: Column(
              children: [
                // header
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping information',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          shape: CircleBorder(),
                          backgroundColor: AppColors.grey,
                          elevation: 0,
                          padding: EdgeInsets.all(0),
                        ),
                        child: Icon(AppIcons.edit, color: AppColors.secondary,),
                      ),
                    ],
                  ),
                ),
                // Name
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: Icon(AppIcons.person)
                      ),
                      Expanded(
                        child: Text(
                          'Arnold Utomo',
                          style: TextStyle(
                            color: AppColors.secondary.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Address
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: Icon(AppIcons.home_1),
                      ),
                      Expanded(
                        child: Text(
                          '1281 90 Trutomo Street, New York, United States ',
                          style: TextStyle(
                            color: AppColors.secondary.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Phone Number
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: Icon(AppIcons.person),
                      ),
                      Expanded(
                        child: Text(
                          '0888 - 8888 - 8888',
                          style: TextStyle(
                            color: AppColors.secondary.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Section 3 - Select Shipping method
          Container(
            margin: EdgeInsets.only(top: 24),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.grey, width: 1),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  // Content
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select Shipping method',
                              style: TextStyle(
                                  color: AppColors.secondary.withOpacity(0.7),
                                  fontSize: 10)),
                          Text('Official Shipping',
                              style: TextStyle(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'poppins')),
                        ],
                      ),
                      Text('free delivery',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Shipping',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondary),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                '3-5 Days',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.secondary.withOpacity(0.7)),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Rp 0',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Subtotal',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondary),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                '4 Items',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.secondary.withOpacity(0.7)),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Rp 1,429,000',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
