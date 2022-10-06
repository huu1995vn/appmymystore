// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class AdvertDetailPage extends StatefulWidget {
  final int? id;
  final AdvertModel? item;

  const AdvertDetailPage({super.key, this.id, this.item});

  @override
  State<AdvertDetailPage> createState() => _AdvertDetailPageState();
}

class _AdvertDetailPageState extends State<AdvertDetailPage> {
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  AdvertModel? data;
  loadData() async {
    try {
      if (widget.item != null) {
        setState(() {
          data = widget.item;
        });
      } else {
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().advertbyid(widget.id!);
        if (res.status > 0) {
          setState(() {
            data = AdvertModel.fromJson(res.data);
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
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  expandedHeight: 250.0,
                  flexibleSpace: avatar(),
                  backgroundColor: Theme.of(context).cardColor,
                  iconTheme: IconThemeData(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  elevation: 0.0,
                  title: Text(
                    "detail.advert".tr,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Form(
                      key: _keyValidationForm,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: kDefaultMarginBottomBox),
                          Card(
                              child: Column(
                            children: [
                              Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.black12),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      data!.adverttypename!,
                                      style: kTextTitleStyle.bold,
                                    ),
                                    subtitle: Text(data!.name!),
                                  )),
                              Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.black12),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "price".tr,
                                      style: kTextTitleStyle.bold,
                                    ),
                                    subtitle: Text(
                                      (data!.price != null && data!.price! > 0)
                                          ? CommonMethods.formatNumber(
                                              data!.price)
                                          : "negotiate".tr,
                                      style: kTextPriceStyle.size(13),
                                    ),
                                  )),
                              Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.black12),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "phone".tr,
                                      style: kTextTitleStyle.bold,
                                    ),
                                    subtitle: Text(
                                      (data!.phone!),
                                    ),
                                  )),
                              Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.black12),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "email".tr,
                                      style: kTextTitleStyle.bold,
                                    ),
                                    subtitle: Text(
                                      (data!.email!),
                                    ),
                                  )),
                              Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.black12),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text.rich(TextSpan(
                                        text: '',
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: "${"expiration.date".tr} ",
                                            style: kTextTitleStyle.bold,
                                          ),
                                          TextSpan(
                                            text: data!.status == 1
                                                ? "active".tr
                                                : "expired".tr,
                                            style: TextStyle(
                                                color: data!.status == 1
                                                    ? Colors.green
                                                    : Colors.red),
                                          )
                                        ])),
                                    // Text(
                                    //   "expiration.date".tr,
                                    //   style: kTextTitleStyle.bold,
                                    // ),
                                    subtitle: Text(
                                        CommonMethods.formatDateTime(
                                            data!.expirationdate,
                                            valueDefault: "not.update".tr),
                                        style: kTextTimeStyle),
                                  )),
                            ],
                          ))
                        ],
                      )),
                )
              ],
            ),
    );
  }

  Widget avatar() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: SizedBox(
        height: 250,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: RxImageProvider(data!.rximg),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data!.displayName!.toUpperCase(),
                    style: const TextStyle(fontSize: 19).bold,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
