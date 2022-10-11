// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';

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
          data = VehicleContactModel.fromJson(res.data);
          if (data!.status == 1) {
            ResponseModel res =
                await DaiLyXeApiBLL_APIUser().vehiclecontactready([data!.id!]);
          }
          setState(() {});
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
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  centerTitle: true,
                  title: Text(
                    data!.vehiclecontacttypeid == 1 ? "pricereport".tr : "testdrive".tr,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(kDefaultPadding * 2),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                data!.subject ?? "NaN",
                                style: const TextStyle(fontSize: 18).bold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                CommonMethods.call(data!.phone!);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Text(data!.phone!,
                                    style: const TextStyle(fontSize: 30)
                                        .textColor(Colors.green)
                                        .bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                data!.contactname!,
                                style: const TextStyle(fontSize: 20).bold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text("email".tr,
                                  style: const TextStyle().bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                CommonMethods.launchURL(
                                    "mailto:" + data!.email!);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(data!.email!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.blue)),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text("vehicle".tr,
                                  style: const TextStyle().bold),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(data!.vehiclename!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text("content".tr,
                                  style: const TextStyle().bold),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(data!.message!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text("from".tr,
                                  style: const TextStyle().bold),
                            ),
                            GestureDetector(
                                onTap: () {
                                  CommonMethods.launchURL(data!.url!);
                                },
                                child: Container(
                                  child: Text(data!.url!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.blue)),
                                )),
                          ],
                        ),
                      ),
                     
                  ),
                )
              ],
            ),
    );
  }

  Widget preview() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(kDefaultPaddingBox),
                      child: Text("preview".tr,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(height: 10),
                Text(
                  data!.contactname!,
                  style: const TextStyle(fontSize: 35).bold,
                ),
                SizedBox(height: 10),
                Text(
                  data!.vehiclename!,
                  style: const TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.phone,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      data!.phone!.toUpperCase(),
                      style: const TextStyle(
                              fontSize: 25, color: AppColors.primary)
                          .bold,
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
