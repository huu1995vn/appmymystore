// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/delegates/rx_select.delegate.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_input.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:raoxe/pages/main/home/widgets/list_banner.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MyProductDetailPage extends StatefulWidget {
  final int? id;
  final ProductModel? item;
  const MyProductDetailPage({super.key, this.id, this.item});

  @override
  State<MyProductDetailPage> createState() => _MyProductDetailPageState();
}

class _MyProductDetailPageState extends State<MyProductDetailPage> {
  AutoScrollController scrollController = AutoScrollController();
  TextStyle styleTitle =
      kTextHeaderStyle.copyWith(fontSize: 15, fontWeight: FontWeight.normal);
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
                      title: Image.asset(
                        LOGORAOXECOLORIMAGE,
                        width: 100,
                      ),
                      centerTitle: true,
                      elevation: 0.0,
                      backgroundColor: AppColors.grey,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.brightness_low_outlined,
                              color: AppColors.black50),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.upload,
                            color: AppColors.black50,
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
        SizedBox(
            height: kSizeHeight,
            child: RxPrimaryButton(onTap: () {}, text: "done".tr()))
      ],
    );
  }

  Widget _listTitle(String title, String subtitle, {Widget? leading}) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: kTextTitleStyle,
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: AppColors.primary),
      ),
    );
  }

  Widget _header(String header) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding)
          .copyWith(left: kDefaultPadding / 2),
      child: Text(
        header,
        style: TextStyle().bold,
      ),
    );
  }

  Widget _radioButton(String text, int value) {
    return Container(
        width: SizeConfig.screenWidth / 2.5,
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              data!.producttypeid = value;
            });
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: (data!.producttypeid == value)
                      ? AppColors.primary
                      : AppColors.black,
                ))),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: (data!.producttypeid == value)
                  ? AppColors.primary
                  : AppColors.black,
            ),
          ),
        ));
  }

  Widget _buildDetail() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _header("BẠN MUỐN"),
        Card(
          child: ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: map<Widget>(
                  MasterDataService.data["productype"],
                  (index, item) {
                    return _radioButton(item["name"], item["id"]);
                  },
                ).toList()),
          ),
        ),
        _header("THÔNG TIN XE"),
        Card(
          child: Column(
            children: [
              _selectInput("brand", data!.brandid,
                  title: "Hãng xe",
                  afterChange: (v) => {
                        setState(() {
                          data!.brandid = CommonMethods.convertToInt32(v);
                        })
                      }),
              ListTile(
                title: Text("price".tr(), style: kTextTitleStyle),
                subtitle: RxInput(
                  keyboardType: TextInputType.number,
                  data!.price!.toString(),
                  onChanged: (v) => {data!.price = CommonMethods.convertToInt32(v)},
                  hintText: "price".tr(),
                ),
              ),
            ],
          ),
        ),
        _header("MÔ TẢ CHI TIẾT"),
        Card(
            child: TextFormField(
          initialValue: data!.description,
          minLines:
              6, // any number you need (It works as the rows for the textarea)
          keyboardType: TextInputType.multiline,
          maxLines: null,
        )),
        _header("THÔNG SỐ KỸ THUẬT"),
        Card(
            child: Column(
          children: [
            _selectInput("producstate", data!.state,
                title: "Tình trạng",
                afterChange: (v) => {
                      setState(() {
                        data!.state = v;
                      })
                    }),
            _selectInput("fueltype", data!.fueltypeid,
                title: "Nhiên liệu",
                afterChange: (v) => {
                      setState(() {
                        data!.fueltypeid = v;
                      })
                    }),
            _selectInput("madein", data!.madeinid,
                title: "Năm sản xuất",
                afterChange: (v) => {
                      setState(() {
                        data!.madeinid = v;
                      })
                    }),
            _selectInput("color", data!.colorid,
                title: "Màu sắc",
                afterChange: (v) => {
                      setState(() {
                        data!.colorid = v;
                      })
                    }),
          ],
        )),
        _header("LIÊN HỆ"),
        Card(
          child: ListTile(
            leading: GestureDetector(
              onTap: () {},
              child: RxAvatarImage(data!.rximguser ?? NOIMAGEUSER, size: 40),
            ),
            title: GestureDetector(
              onTap: () {},
              child: Text(data!.usercontactname ?? "Nguyễn Trọng Hữu",
                  style: const TextStyle().bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // spacing: kDefaultPadding,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  data!.usercontactphone ?? "0379787904",
                  style: const TextStyle(
                    color: AppColors.black50,
                  ).bold.size(12),
                ),
                Text(
                  data!.usercontactaddress ?? "Tp.HCM",
                  style: const TextStyle(
                    color: AppColors.black50,
                  ).bold.size(12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _onSelect(String type, int id,
      {bool Function(dynamic)? fnWhere, Function(dynamic)? afterChange}) async {
    List data = MasterDataService.data[type];
    if (fnWhere != null) {
      data = data.where(fnWhere!).toList();
    }
    var res = await showSearch(
        context: context, delegate: RxSelectDelegate(data: data, value: id));
    if (res != null) {
      if (afterChange != null) afterChange!(res);
    }
  }

  Widget _selectInput(
    String type,
    dynamic value, {
    String? title,
    String hideText = "Chọn lọc",
    bool Function(dynamic)? fnWhere,
    dynamic Function(dynamic)? afterChange,
  }) {
    var name = CommonMethods.getNameMasterById(type, value);
    return ListTile(
      title: Text(
        title ?? type.tr(),
        style: styleTitle,
      ),
      subtitle: Text(name != null && name.length > 0 ? name : hideText,
          style: TextStyle(
              color:
                  name != null && name.length > 0 ? AppColors.primary : null)),
      onTap: () =>
          _onSelect(type, value, fnWhere: fnWhere, afterChange: afterChange),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }
}
