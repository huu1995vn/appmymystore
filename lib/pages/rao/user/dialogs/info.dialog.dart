// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, prefer_is_empty, non_constant_identifier_names, must_be_immutable

import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/app_provider.dart';
import 'package:raoxe/core/services/file.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
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
      data = widget.data.clone();
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

  // _onAddress() async {
  //   var res = await CommonNavigates.showDialogBottomSheet(
  //       context, AddressDialog(contact: data!.toContact()),
  //       height: 350);

  //   if (res != null) {
  //     setState(() {
  //       data!.cityid = res.cityid;
  //       data!.districtid = res.districtid;
  //       data!.address = res.address;
  //     });
  //   }
  // }

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
                    iconTheme: const IconThemeData(
                      color: AppColors.white,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Form(
                        key: _keyValidationForm,
                        child: Column(
                          children: <Widget>[
                            Card(
                              child: Avatar(),
                            ),
                            SizedBox(height: kDefaultMarginBottomBox),
                            Card(
                                child: Column(
                              children: [
                                rxTextInput(context, data!.fullname,
                                    labelText: "fullname".tr,
                                    onChanged: (v) => {data!.fullname = v},
                                    validator: Validators.compose([
                                      Validators.required("notempty".tr),
                                    ])), 
                                Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.black12),
                                      ),
                                    ),
                                    child: ListTile(
                                      title: RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "birthday".tr,
                                                style: kTextTitleStyle.copyWith(
                                                    fontSize: 12,
                                                    color: Colors.black54)),
                                            const TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.primary)),
                                          ],
                                        ),
                                      ),
                                      trailing:
                                          FaIcon(FontAwesomeIcons.calendar),
                                      subtitle: Container(
                                        height: 35,
                                        child: DateTimePicker(
                                            dateHintText: "birthday".tr,
                                            style: TextStyle(
                                                    color: data!.birthdate !=
                                                                null &&
                                                            data!.birthdate!
                                                                    .toString()
                                                                    .length >
                                                                0
                                                        ? AppColors.black
                                                        : null)
                                                .size(16),
                                            locale: Locale(
                                                Get.locale!.languageCode ??
                                                    "en"),
                                            initialValue:
                                                CommonMethods.convertToDateTime(
                                                        data!.birthdate!)
                                                    .toString(),
                                            dateMask: 'dd-MM-yyyy',
                                            firstDate: DateTime(1977),
                                            lastDate: DateTime(2100),
                                            onChanged: (value) =>
                                                {data!.birthdate = value},
                                            validator: Validators.compose([
                                              Validators.required(
                                                  "birthday".tr),
                                            ])),
                                      ),
                                    )),
                                SizedBox(height: 10),
                                ListTile(
                                  title: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "gender".tr,
                                            style: kTextTitleStyle.copyWith(
                                                fontSize: 12,
                                                color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      CustomRadioButton("male".tr, 1),
                                      SizedBox(width: 10),
                                      CustomRadioButton("female".tr, 0),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ))
                          ],
                        )),
                  )
                ],
              ),
        persistentFooterButtons: [
          if (data != null)
            Row(
              children: [
                Expanded(
                    child: RxPrimaryButton(
                        onTap: () {
                          if (_keyValidationForm.currentState!.validate()) {
                            _onSave();
                          }
                        },
                        text: 'save'.tr))
              ],
            )
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
        height: 200,
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
                            colorIcon: Colors.white,
                            onTap: onUpload,
                            size: 40,
                            color: Colors.grey,
                          )),
                      radius: 60.0,
                      backgroundImage: RxImageProvider(data!.rximg),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data!.fullname!.toUpperCase(),
                    style: const TextStyle(fontSize: 19).bold,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
