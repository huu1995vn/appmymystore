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
                  floating: true,
                  centerTitle: true,
                  title: Text(
                    data!.name!,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Form(
                      key: _keyValidationForm,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: kDefaultMarginBottomBox),
                          Card(
                              margin: EdgeInsets.only(
                                  bottom: kDefaultMarginBottomBox),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.all(kDefaultPaddingBox),
                                      child: Text("info".tr,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    ListTile(
                                        title: Text("status".tr),
                                        trailing: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: data!.status == 1
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 4),
                                            child: Text(
                                                data!.status == 1
                                                    ? "active".tr
                                                    : "expired".tr,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white)))),
                                    ListTile(
                                      title: Text("expiration.date".tr),
                                      trailing: Text(
                                          CommonMethods.formatDateTime(
                                              data!.expirationdate,
                                              valueDefault: "not.update".tr),
                                          style: kTextTitleStyle.bold),
                                    ),
                                    ListTile(
                                        title: Text("price".tr),
                                        trailing: Text(
                                            (data!.price != null &&
                                                    data!.price! > 0)
                                                ? CommonMethods
                                                    .formatShortCurrency(
                                                        data!.price)
                                                : "negotiate".tr,
                                            style: kTextPriceStyle.size(16))),
                                    ListTile(
                                      title: Text("phone".tr),
                                      trailing: Text(
                                        data!.phone!,
                                        style: kTextTitleStyle,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("email".tr),
                                      trailing: Text(data!.email!,
                                          style: kTextTitleStyle),
                                    ),
                                  ])),
                          Card(
                            child: preview(),
                          ),
                          SizedBox(height: kDefaultMarginBottomBox),
                        ],
                      )),
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
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: RxImageProvider(data!.rximg),
                ),
                SizedBox(height: 10),
                Text(
                  data!.displayName!,
                  style: const TextStyle(fontSize: 35).bold,
                ),
                SizedBox(height: 10),
                Text(
                  data!.jobtitle!,
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
