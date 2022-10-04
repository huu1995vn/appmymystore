// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, prefer_is_empty, non_constant_identifier_names, must_be_immutable

import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/dialogs/address.dialog.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/app_provider.dart';
import 'package:raoxe/core/services/file.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
// ignore: unused_import
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class InfoUserDiaLog extends StatefulWidget {
  InfoUserDiaLog({super.key, required this.data});
  UserModel data;
  @override
  State<InfoUserDiaLog> createState() => _InfoUserDiaLogState();
}

class _InfoUserDiaLogState extends State<InfoUserDiaLog> {
  UserModel? data;
  String urlImage = "";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    setState(() {
      data = widget.data;
    });
  }

  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();

  Future onUpload() async {
    try {
      String pathfile = await FileService.getImagePicker(context,
          cropImage: true, circleShape: true);
      File file = File(pathfile);
      if (file == null) return;
      CommonMethods.lockScreen();
      if (file != null) {
        int fileId = await FileService.uploadImage(file,
            idFile: -1, name: data!.fullname!);
        // ignore: curly_braces_in_flow_control_structures
        if (data!.img != fileId) {
          var dataClone = data!.clone();
          dataClone.img = fileId;
          ResponseModel res =
              await DaiLyXeApiBLL_APIUser().updateavatar(fileId);
          if (res.status > 0) {
            setState(() {
              data = dataClone;
            });
          } else {
            CommonMethods.showToast(res.message);
          }
          Provider.of<AppProvider>(context, listen: false)
              .setUserData(img: fileId);
        }
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }

    CommonMethods.unlockScreen();
  }

  _onSave() async {
    CommonMethods.lockScreen();
    try {
      var dataClone = data!.clone();
      ResponseModel res =
          await DaiLyXeApiBLL_APIUser().updateuser(dataClone.toUpdate());
      if (res.status > 0) {
        setState(() {
          data = dataClone;
        });
        CommonMethods.showToast("success".tr);
      } else {
        CommonMethods.showToast(res.message);
      }
      Provider.of<AppProvider>(context, listen: false).setUserModel(dataClone);
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }

    CommonMethods.unlockScreen();
  }

  _onAddress() async {
    var res = await CommonNavigates.showDialogBottomSheet(
        context, AddressDialog(contact: data!.toContact()),
        height: 350);

    if (res != null) {
      setState(() {
        data!.cityid = res.cityid;
        data!.districtid = res.districtid;
        data!.address = res.address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: data == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 250.0,
                    flexibleSpace: Avatar(),
                  ),
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Form(
                        key: _keyValidationForm,
                        child: Card(
                            child: Column(
                          children: <Widget>[
                            rxTextInput(context, data!.fullname,
                                labelText: "fullname".tr,
                                onChanged: (v) => {data!.fullname = v},
                                validator: Validators.compose([
                                  Validators.required("fullname".tr),
                                ])),
                            rxTextInput(context, data!.address,
                                labelText: "address".tr,
                                onTap: _onAddress,
                                validator: Validators.compose([
                                  Validators.required("fullname".tr),
                                ])),
                            ListTile(
                              title: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "birthday".tr,
                                        style: kTextTitleStyle.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color)),
                                    const TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary)),
                                  ],
                                ),
                              ),
                              subtitle: DateTimePicker(
                                  dateHintText: "birthday".tr,
                                  style: TextStyle(
                                          color: data!.birthdate != null &&
                                                  data!.birthdate!
                                                          .toString()
                                                          .length >
                                                      0
                                              ? AppColors.primary
                                              : null)
                                      .size(13),
                                  locale: Locale("vi"),
                                  initialValue: CommonMethods.convertToDateTime(
                                          data!.birthdate!)
                                      .toString(),
                                  dateMask: 'dd-MM-yyyy',
                                  firstDate: DateTime(1977),
                                  lastDate: DateTime(2100),
                                  onChanged: (value) =>
                                      {data!.birthdate = value},
                                  validator: Validators.compose([
                                    Validators.required("birthday".tr),
                                  ])),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  CustomRadioButton("male".tr, 1),
                                  CustomRadioButton("female".tr, 0),
                                ],
                              ),
                            )
                          ],
                        ))),
                  ))
                ],
              ),
        persistentFooterButtons: [
          if (data != null)
            RxPrimaryButton(
                onTap: () {
                  if (_keyValidationForm.currentState!.validate()) {
                    _onSave();
                  }
                },
                text: 'save'.tr)
        ]);
  }

  Widget CustomRadioButton(String text, dynamic value) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          data!.gender = value;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color:
              (data!.gender == value) ? AppColors.primary : AppColors.black50,
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: (data!.gender == value)
                    ? AppColors.primary
                    : AppColors.black50))),
      ),
    );
  }

  Widget Avatar() {
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
                    // backgroundColor: AppColors.white,
                    backgroundImage:
                        const AssetImage('assets/loading_icon.gif'),
                    child: CircleAvatar(
                      // backgroundColor: Colors.white,
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: RxIconButton(
                            icon: AppIcons.camera_1,
                            onTap: onUpload,
                            size: 40,
                          )),
                      radius: 60.0,
                      backgroundImage: RxImageProvider(data!.rximg),
                    ),
                  ),
                  Text(
                    data!.fullname!.toUpperCase(),
                    style: const TextStyle(fontSize: 19).bold,
                  ),
                  Text(
                    data!.email!,
                  ),
                  Text(
                    data!.phone!,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
