// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:raoxe/pages/main/home/widgets/list_banner.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ProductDetailPage extends StatefulWidget {
  final int? id;
  final ProductModel? item;
  const ProductDetailPage({super.key, this.id, this.item});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  AutoScrollController scrollController = AutoScrollController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // String title = "";
  String? initialUrl;
  ProductModel? data;
  bool isNotFound = false;
  loadData() async {
    if (widget.item != null) {
      setState(() {
        data = widget.item!;
      });
    } else {
      ResponseModel res = await DaiLyXeApiBLL_APIGets().newsdetail(widget.id!);
      if (res.status > 0) {
        setState(() {
          data = ProductModel.fromJson(res.data);
        });
      } else {
        setState(() {
          isNotFound = true;
        });
        CommonMethods.showToast(res.message);
      }
    }
  }

  bool get isLike {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isNotFound
          ? Expanded(child: Center(child: Text("not.found".tr())))
          : (data == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RxCustomScrollView(
                  key: const Key("iProduct"),
                  controller: scrollController,
                  slivers: <Widget>[
                    SliverAppBar(
                      iconTheme: IconThemeData(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color, //change your color here
                      ),
                      centerTitle: true,
                      elevation: 0.0,
                      backgroundColor: AppColors.grey,
                      actions: <Widget>[
                        // Text("Tin ưu tiên",
                        //     style: const TextStyle(
                        //       color: AppColors.yellow,
                        //     ).bold),
                        IconButton(
                          icon: Icon(Icons.email, color: AppColors.yellow),
                          onPressed: () {
                            CommonMethods.launchURL(
                                "mailto:" + data!.usercontactemail!.toString());
                          },
                        ),
                        IconButton(
                          icon: Icon(
                              isLike
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: AppColors.primary),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: AppColors.info,
                          ),
                          tooltip: 'Share',
                          onPressed: () {
                            // onSetting(context);
                          },
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: _buildDetail(),
                    ))
                  ],
                )),
      persistentFooterButtons: [
        if (data != null)
          RxPrimaryButton(
              onTap: () {}, text: data!.usercontactphone ?? "0379787904")
      ],
    );
  }

  Widget _listTitle(String title, String subtitle, {Widget? leading}) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: kTextHeaderStyle,
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: AppColors.primary),
      ),
    );
  }

  Widget _buildDetail() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: GestureDetector(
                  onTap: () {},
                  child:
                      RxAvatarImage(data!.URLIMGUSER ?? NOIMAGEUSER, size: 40),
                ),
                title: GestureDetector(
                  onTap: () {},
                  child: Text(data!.usercontactname ?? "",
                      style: const TextStyle().bold),
                ),
                subtitle: Row(
                  // spacing: kDefaultPadding,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data!.usercontactaddress,
                      style: const TextStyle(
                        color: AppColors.black50,
                      ).bold.size(12),
                    ),
                  ],
                ),
              ),
            ),

            ListBannerWidget(),

            if (data!.state == "1")
              Card(
                child: Column(
                  children: [
                    Text(
                      "Thông tin thông số".toUpperCase(),
                      style: const TextStyle().bold,
                    ),
                    _listTitle("vehiclelife".tr(), data!.madeinname),
                    _listTitle("vehicletype".tr(), data!.modelname),
                    _listTitle("vehicle".tr(), data!.bodytypename),
                    _listTitle("fuel".tr(), data!.fueltypename),
                    _listTitle("color".tr(), data!.colorname),
                  ],
                ),
              ),
            Card(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: Icon(
                      Icons.security,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "message.str012".tr(),
                                ),
                              ),
                              ElevatedButton.icon(
                                  onPressed: () {
                                    // onReport(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.yellow),
                                  ),
                                  icon: Icon(Icons.warning),
                                  label: Text(
                                      "report.violation".tr().toUpperCase()))
                            ],
                          )))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(bottom: 0),
              alignment: Alignment.centerLeft,
              child: Text(
                "news.related".tr().toUpperCase(),
                style: const TextStyle().bold,
              ),
            ),
            // TinRaoLienQuanList({
            //   CommonParams.idDongXes: data.IdDongXe,
            //   CommonParams.notId: data.Id
            // }),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                "evaluate".tr().toUpperCase(),
                style: const TextStyle().bold,
              ),
            ),
            // CardBorder(child: Rating(data, onLogin: onLogin)),
          ],
        ),
      ],
    );
  }
}
