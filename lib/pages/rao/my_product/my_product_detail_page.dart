// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/delegates/rx_select.delegate.dart';
import 'package:raoxe/core/components/dialogs/photo_view.dialog.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/components/rx_image.dart';
import 'package:raoxe/core/components/rx_input.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/file.service.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../core/commons/common_configs.dart';

class MyProductDetailPage extends StatefulWidget {
  final int? id;
  final ProductModel? item;
  final void Function(ProductModel)? onChanged;
  const MyProductDetailPage({super.key, this.id, this.item, this.onChanged});

  @override
  State<MyProductDetailPage> createState() => _MyProductDetailPageState();
}

class _MyProductDetailPageState extends State<MyProductDetailPage> {
  List<ContactModel> lContacts = [];
  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  AutoScrollController scrollController = AutoScrollController();
  TextStyle styleTitle =
      kTextHeaderStyle.copyWith(fontSize: 15, fontWeight: FontWeight.normal);
  @override
  void initState() {
    super.initState();
    loadData();
  }

  List<ContactModel> list = <ContactModel>[];
  // String title = "";
  String? initialUrl;
  ProductModel? data;
  bool isNotFound = false;
  List<String> imgs = <String>[];
  loadData() async {
    ProductModel? _data;
    if (widget.item != null) {
      _data = widget.item!;
    } else {
      ResponseModel res = await DaiLyXeApiBLL_APIGets().productbyid(widget.id!);
      if (res.status > 0) {
        setState(() {
          _data = ProductModel.fromJson(res.data);
        });
      } else {
        setState(() {
          isNotFound = true;
        });
        CommonMethods.showToast(res.message);
      }
    }
    if (_data!.usercontactid <= 0) {
      lContacts = await _loadContact();
      if (lContacts.isEmpty || lContacts.isEmpty) {
        CommonMethods.showToast("message.str013".tr);
        CommonNavigates.goBack(context);
        return;
      }
      ContactModel contact =
          lContacts.firstWhere((element) => element.isdefault == true) ??
              lContacts[0];
      _data!.setcontact(contact);
    }

    setState(() {
      data = _data;
      imgs = _data!.rximglist;
    });
  }

  bool get isLike {
    return false;
  }

  chooseImages() async {
    int maxImages = kMaxImages - imgs.length;
    if (maxImages <= 0) {
      return;
    }
    var limg =
        await FileService.getMultiImagePicker(context, maxImages: maxImages);
    if (limg.isNotEmpty) {
      setState(() {
        imgs.addAll(limg);
      });
    }
  }

  onUpTop() async {
    if (data!.status != 2) {
      CommonMethods.showToast("message.str015".tr);
      return;
    }
    CommonMethods.lockScreen();
    try {
      Map<String, dynamic> body = <String, dynamic>{};
      body["ids"] = [data!.id];
      ResponseModel res = await DaiLyXeApiBLL_APIUser().productuptop(body);
      if (res.status > 0) {
        CommonMethods.showToast("update.success".tr);
      } else {
        CommonMethods.showDialogError(context, res.message);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
    CommonMethods.unlockScreen();
  }

  _loadContact() async {
    ResponseModel res =
        await DaiLyXeApiBLL_APIUser().contact(<String, dynamic>{});
    if (res.status > 0) {
      return CommonMethods.convertToList<ContactModel>(
          res.data, (val) => ContactModel.fromJson(val));
    } else {
      CommonMethods.showToast(res.message);
    }
    return [];
  }

  _onAddress() async {
    ResponseModel res =
        await DaiLyXeApiBLL_APIUser().contact(<String, dynamic>{});
    if (res.status > 0) {
      list = CommonMethods.convertToList<ContactModel>(
          res.data, (val) => ContactModel.fromJson(val));
      if (list.isEmpty) {
        CommonMethods.showDialogWarning(
            context, "Vui lòng tạo địa chỉ trước khi tạo tin");
        return;
      }
    } else {
      CommonMethods.showToast(res.message);
    }

    ContactModel contact = await showSearch(
        context: context,
        delegate: RxSelectDelegate(
            data: list,
            value: -1,
            itemBuilder: (context, index) {
              ContactModel item = list[index];
              return Card(
                  child: RadioListTile(
                // leading: const RxCircleAvatar(
                //     backgroundColor: Colors.grey,
                //     child: Icon(AppIcons.map_marker,
                //         size: 20, color: Colors.white)),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.fullname ?? "NaN",
                    ),
                    Text(
                      item.isdefault ? "default".tr : "",
                      style: const TextStyle(color: AppColors.blue),
                    ),
                  ],
                ),
                value: item.id,
                groupValue: data!.usercontactid,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (item.cityid != null || item.cityid > 0)
                          Text(
                            item.cityname ?? "NaN",
                            style: const TextStyle(color: AppColors.blue),
                          ),
                        Text(
                          item.phone ?? "NaN",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      item!.address ?? "NaN",
                      style: const TextStyle(),
                    )
                  
                  ],
                ),
                onChanged: (int? value) {
                  CommonNavigates.goBack(context, item);
                },
                // trailing: Text(item.phone ?? "",
                //     style: const TextStyle(fontSize: 16)),
                // onTap: () {
                //   CommonNavigates.goBack(context, item);
                // })
              ));
            }));
    if (contact != null) {
      setState(() {
        data!.setcontact(contact);
      });
    }
  }

  _onSave() async {
    CommonMethods.lockScreen();
    try {
      List<int> idFiles = await FileService.convertListHinhAnhToListInt(imgs,
          name: data!.name!);
      if (idFiles.isEmpty) {
        CommonMethods.showToast("message.str007".tr);
        return;
      }
      if (idFiles.isNotEmpty) {
        setState(() {
          data!.imglist = idFiles.join(',');
          data!.img = idFiles[0];
        });
      }
      ProductModel dataClone = data!.clone();

      ResponseModel res = await DaiLyXeApiBLL_APIUser().productsavedata(
          data!.id > 0 ? dataClone.toUpdate() : dataClone.toInsert());
      if (res.status > 0) {
        if (widget.onChanged != null) {
          widget.onChanged!(dataClone);
        }
        CommonMethods.unlockScreen();
        await CommonMethods.showConfirmDialog(context,
            dataClone.id > 0 ? "update.success".tr : "create.success".tr);
        if (!(data!.id > 0)) {
          CommonNavigates.goBack(context, dataClone);
        }
      } else {
        CommonMethods.showDialogError(context, res.message);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
    CommonMethods.unlockScreen();
  }

  _onDelete() async {
    var res =
        await CommonMethods.showConfirmDialog(context, "message.alert01".tr);
    if (res) {
      CommonMethods.lockScreen();
      try {
        ResponseModel res =
            await DaiLyXeApiBLL_APIUser().productdelete([data!.id]);
        if (res.status > 0) {
          CommonMethods.unlockScreen();
          await CommonMethods.showConfirmDialog(context, "delete.success".tr);
          CommonNavigates.goBack(context, ProductModel());
        } else {
          CommonMethods.showDialogError(context, res.message);
        }
      } catch (e) {
        CommonMethods.showDialogError(context, e);
      }
      CommonMethods.unlockScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isNotFound
          ? Expanded(child: Center(child: Text("not.found".tr)))
          : (data == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RxCustomScrollView(
                  key: const Key("iProduct"),
                  controller: scrollController,
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text(CommonMethods.convertToString(
                          data!.name ?? "create".tr)),
                      centerTitle: true,
                      elevation: 0.0,
                    ),
                    SliverToBoxAdapter(
                      child: Form(
                          key: _keyValidationForm,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              _header(title: "youwant".tr.toUpperCase()),
                              Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: map<Widget>(
                                      MasterDataService.data["producttype"],
                                      (index, item) {
                                        return _radioProductType(
                                            item["name"], item["id"]);
                                      },
                                    ).toList()),
                              ),
                              _header(title: "generalinfor".tr),
                              Card(
                                margin: const EdgeInsets.only(bottom: 6),
                                child: Column(
                                  children: [
                                    rxSelectInput(
                                        context, "brand", data!.brandid,
                                        labelText: "brand".tr,
                                        afterChange: (v) => {
                                              setState(() {
                                                data!.brandid = CommonMethods
                                                    .convertToInt32(v);
                                                data!.modelid = -1;
                                              })
                                            },
                                        validator: (v) {
                                          if (!(data!.brandid > 0)) {
                                            return "notempty".tr;
                                          }
                                          return null;
                                        }),
                                    rxSelectInput(
                                        context, "model", data!.modelid,
                                        labelText: "model".tr,
                                        afterChange: (v) => {
                                              setState(() {
                                                data!.modelid = CommonMethods
                                                    .convertToInt32(v);
                                              })
                                            },
                                        fnWhere: (e) {
                                          return e["brandid"] == data!.brandid;
                                        },
                                        validator: (v) {
                                          if (!(data!.modelid > 0)) {
                                            return "notempty".tr;
                                          }
                                          return null;
                                        }),
                                    rxSelectInput(
                                        context, "bodytype", data!.bodytypeid,
                                        labelText: "bodytype".tr,
                                        afterChange: (v) => {
                                              setState(() {
                                                data!.bodytypeid = CommonMethods
                                                    .convertToInt32(v);
                                              })
                                            },
                                        validator: (v) {
                                          if (!(data!.bodytypeid > 0)) {
                                            return "notempty".tr;
                                          }
                                          return null;
                                        }),
                                    ListTile(
                                      title: Row(
                                        children: [
                                          Text("${'price'.tr}: ",
                                              style: kTextTitleStyle.size(13)),
                                          Text(
                                            (data!.price != null &&
                                                    data!.price! > 0)
                                                ? CommonMethods.formatNumber(
                                                    data!.price)
                                                : "negotiate".tr,
                                            style: kTextPriceStyle.size(13),
                                          )
                                        ],
                                      ),
                                      subtitle: RxInput(
                                        keyboardType: TextInputType.number,
                                        data!.price?.toString() ?? "",
                                        onChanged: (v) {
                                          setState(() {
                                            data!.price =
                                                CommonMethods.convertToInt32(v);
                                          });
                                        },
                                        hintText: "price".tr,
                                        style: const TextStyle(
                                                color: AppColors.black)
                                            .size(16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                margin: const EdgeInsets.only(bottom: 6),
                                child: Column(children: [
                                  ListTile(
                                      title: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "title".tr,
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12)),
                                        const TextSpan(
                                            text: "*",
                                            style: TextStyle(
                                                color: AppColors.primary))
                                      ])),
                                      subtitle: Container(
                                        height: 30,
                                        child: TextFormField(
                                          showCursor: true,
                                          key: const Key("name"),
                                          initialValue: data!.name,
                                          keyboardType: TextInputType.multiline,
                                          onChanged: (value) =>
                                              {data!.name = value},
                                          decoration: InputDecoration(
                                            hintText: "please.enter".tr,
                                          ),
                                          validator: (value) {
                                            if ((data!.name == null ||
                                                data!.name!.isEmpty)) {
                                              return "notempty".tr;
                                            }
                                            return null;
                                          },
                                        ),
                                      )),
                                  ListTile(
                                    title: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "description".tr,
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12)),
                                      const TextSpan(
                                          text: "*",
                                          style: TextStyle(
                                              color: AppColors.primary))
                                    ])),
                                    subtitle: TextFormField(
                                      showCursor: true,
                                      key: const Key("desc"),
                                      initialValue: data!.desc,
                                      minLines:
                                          6, // any number you need (It works as the rows for the textarea)
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      onChanged: (value) =>
                                          {data!.desc = value},
                                      decoration: InputDecoration(
                                        hintText: "please.enter".tr,
                                      ),
                                      maxLength: 1500,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.none,
                                      validator: (value) {
                                        if ((data!.desc == null ||
                                            data!.desc!.isEmpty)) {
                                          return "notempty".tr;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ]),
                              ),
                              _header(
                                  header: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "image".tr.toUpperCase(),
                                            style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .color)
                                                .bold),
                                        TextSpan(
                                            text:
                                                " (${imgs.length}/$kMaxImages)",
                                            style: const TextStyle(
                                                color: AppColors.primary)),
                                      ],
                                    ),
                                  ),
                                  action: GestureDetector(
                                      onTap: chooseImages,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(AppIcons.upload_1,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color),
                                            ),
                                            TextSpan(
                                                text: " ${"add.image".tr}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .color)),
                                          ],
                                        ),
                                      ))),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Card(

                                    // padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(bottom: 6),
                                    child: Column(children: [
                                      SizedBox(
                                        height: 250,
                                        child: GridView.builder(
                                            padding:
                                                const EdgeInsets.only(top: 0.0),
                                            shrinkWrap: true,
                                            itemCount: imgs.length > 7
                                                ? 7
                                                : imgs.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4),
                                            itemBuilder: (context, index) {
                                              return Card(
                                                  child: _itemImage(index,
                                                      onDelete: () => {},
                                                      onShowPhoTo: () => {
                                                            CommonNavigates
                                                                .openDialog(
                                                                    context,
                                                                    PhotoViewDialog(
                                                                      initialPage:
                                                                          index,
                                                                      imgs:
                                                                          imgs,
                                                                      onDelete:
                                                                          (i) =>
                                                                              {
                                                                        setState(
                                                                            () {
                                                                          imgs.removeAt(
                                                                              i);
                                                                        })
                                                                      },
                                                                    ))
                                                          }));
                                            }),
                                      ),
                                    ])),
                              ),
                              _header(title: "specifications".tr),
                              Card(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  child: Column(
                                    children: [
                                      rxSelectInput(
                                          context, "productstate", data!.state,
                                          labelText: "state".tr,
                                          afterChange: (v) => {
                                                setState(() {
                                                  data!.state = v;
                                                })
                                              },
                                          validator: (v) {
                                            if (!(data!.state > 0)) {
                                              return "notempty".tr;
                                            }
                                            return null;
                                          }),
                                      rxSelectInput(
                                        context,
                                        "fueltype",
                                        data!.fueltypeid,
                                        labelText: "fueltype".tr,
                                        afterChange: (v) => {
                                          setState(() {
                                            data!.fueltypeid = v;
                                          })
                                        },
                                      ),
                                      rxSelectInput(
                                          context, "madein", data!.madeinid,
                                          labelText: "madein".tr,
                                          afterChange: (v) => {
                                                setState(() {
                                                  data!.madeinid = v;
                                                })
                                              }),
                                      rxSelectInput(
                                          context, "productdoor", data!.door,
                                          labelText: "door".tr,
                                          afterChange: (v) => {
                                                setState(() {
                                                  data!.door = v;
                                                })
                                              }),
                                      rxSelectInput(
                                          context, "productseat", data!.seat,
                                          labelText: "seat".tr,
                                          afterChange: (v) => {
                                                setState(() {
                                                  data!.seat = v;
                                                })
                                              }),
                                      rxSelectInput(
                                          context, "color", data!.colorid,
                                          labelText: "color".tr,
                                          afterChange: (v) => {
                                                setState(() {
                                                  data!.colorid = v;
                                                })
                                              }),
                                      rxSelectInput(context, "year", data!.year,
                                          labelText: "year".tr,
                                          afterChange: (v) => {
                                                setState(() {
                                                  data!.year = v;
                                                })
                                              }),
                                      // ListTile(
                                      //   title: Text('year'.tr,
                                      //       style: kTextTitleStyle),
                                      //   subtitle: RxInput(
                                      //     keyboardType: TextInputType.number,
                                      //     data!.year?.toString() ?? "",
                                      //     onChanged: (v) {
                                      //       setState(() {
                                      //         data!.year =
                                      //             CommonMethods.convertToInt32(
                                      //                 v);
                                      //       });
                                      //     },
                                      //     hintText: "year".tr,
                                      //     style: const TextStyle(
                                      //             color: AppColors.primary)
                                      //         .size(16),
                                      //   ),
                                      // ),
                                    ],
                                  )),
                              _header(
                                header: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "contact".tr.toUpperCase(),
                                          style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color)
                                              .bold),
                                    ],
                                  ),
                                ),
                              ),
                              _contact(),
                              if (data != null && data!.id > 0)
                                Padding(
                                  padding: EdgeInsets.all(kDefaultPadding),
                                  child: Card(
                                      child: Row(
                                    children: [
                                      Expanded(
                                          child: RxRoundedButton(
                                              onPressed: _onDelete,
                                              title: "delete".tr))
                                    ],
                                  )),
                                )
                            ],
                          )),
                    )
                  ],
                )),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.only(right: 5),
                child: RxPrimaryButton(
                    onTap: () {
                      if (_keyValidationForm.currentState!.validate()) {
                        _onSave();
                      }
                    },
                    text: "save".tr),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: RxButton(
                        color: Colors.green,
                        icon: FaIcon(FontAwesomeIcons.arrowUp),
                        onTap: onUpTop,
                        text: "uptop".tr))),
          ],
        )
      ],
    );
  }

  Widget _contact() {
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        leading: RxAvatarImage(data!.rximguser, size: 50),
        title: Text(data!.fullname ?? "NaN", style: const TextStyle().bold),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (data!.cityid != null || data!.cityid! > 0)
                  Text(
                    data!.cityname ?? "NaN",
                    style: const TextStyle(color: AppColors.blue),
                  ),
                Text(
                  data!.phone ?? "NaN",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Text(
              data!.address ?? "NaN",
              style: const TextStyle(),
            )
          ],
        ),
        trailing: const Icon(AppIcons.chevron_right),
        onTap: _onAddress,
      ),
    );
  }

  Widget _itemImage(int index,
      {void Function()? onDelete, void Function()? onShowPhoTo}) {
    String img = imgs[index];
    bool showPlus = index == 7 && imgs.length > 8;
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(onTap: onShowPhoTo, child: RxImage(img)),
        if (showPlus)
          Positioned(
              top: 0,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.black,
                  ),
                  height: SizeConfig.screenWidth / 4,
                  width: SizeConfig.screenWidth / 4,
                ),
              )),
        if (showPlus)
          Center(
              child: Text("+${imgs.length - 8}",
                  style:
                      const TextStyle(color: AppColors.white).size(17).bold)),
        if (!showPlus)
          Positioned(
              top: 2,
              right: 2,
              child: Opacity(
                opacity: 0.7,
                child: GestureDetector(
                  onTap: _onDelete,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                    ),
                    // height: SizeConfig.screenWidth / 4,
                    // width: SizeConfig.screenWidth / 4,
                    child: const Icon(
                      AppIcons.close,
                      color: AppColors.white,
                    ),
                  ),
                ),
              )),
      ],
    );
  }

  Widget _header({String? title, Widget? header, Widget? action}) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          header ??
              Text(
                title!.toUpperCase(),
                style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color)
                    .bold,
              ),
          if (action != null) action
        ],
      ),
    );
  }

  Widget _radioProductType(String text, int value) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: (SizeConfig.screenWidth - 30) / 2,
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              data!.producttypeid = value;
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return (data!.producttypeid == value)
                  ? AppColors.primary
                  : AppColors.white;
            }),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
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
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
        ));
  }
}
