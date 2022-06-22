// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/dialogs/contact.dialog.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/user_provider.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/file.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'widgets/user_top.widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserModel? data;
  String urlImage = "";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  final GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  // String birthdate = "";
  // String fullname = "";
  // String address = "";
  // int gender = 1;

  loadData() async {
    try {
      ResponseModel res = await DaiLyXeApiBLL_APIUser().getuser();
      if (res.status > 0) {
        var user = UserModel.fromJson(jsonDecode(res.data));
        setState(() {
          data = user;
          urlImage = data!.URLIMG;
        });
        // birthdate = CommonMethods.convertToDateTime(user.birthdate).toString();
        // fullname = user.fullname;
        // address = user.address;
        // gender = int.parse(user.gender);
        Provider.of<UserProvider>(context, listen: false).setUserModel(user);
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }

  Future onUpload() async {
    try {
      File? file = await FileService.getImagePicker(context,
          cropImage: true, circleShape: true);
      if (file == null) return;
      CommonMethods.lockScreen();
      if (file != null) {
        int img = int.parse(data!.img ?? "-1");
        String fullname = data!.fullname;
        int idAvatar =
            await FileService().uploadImage(file, idFile: -1, name: fullname);
        // ignore: curly_braces_in_flow_control_structures
        if (img != idAvatar) {
          var dataClone = data!.clone();
          dataClone.img = idAvatar.toString();

          ResponseModel res =
              await DaiLyXeApiBLL_APIUser().updateuser(dataClone.toUpdate());
          if (res.status > 0) {
            setState(() {
              data = dataClone;
              APITokenService.img = idAvatar;
            });
          } else {
            CommonMethods.showToast(res.message);
          }
          Provider.of<UserProvider>(context, listen: false)
              .setData(img: idAvatar.toString());
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
      } else {
        CommonMethods.showToast(res.message);
      }
      Provider.of<UserProvider>(context, listen: false).setUserModel(dataClone);
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }

    CommonMethods.unlockScreen();
  }

  _onAddress() async {
    var res = await CommonNavigates.openDialog(
        context, ContactDialog(contact: data!.toContact()));
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
      backgroundColor: Theme.of(context).cardColor,
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                    expandedHeight: 250.0,
                    flexibleSpace: UserTopWidget(data, onUpload: onUpload)),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _keyValidationForm,
                    child: Column(
                      children: <Widget>[
                        RxInput(data!.fullname,
                            labelText: "fullname".tr(),
                            isBorder: true,
                            // icon: const Icon(Icons.person),
                            onChanged: (v) => {data!.fullname = v},
                            validator: Validators.compose([
                              Validators.required(
                                  "notempty.fullname.text".tr()),
                            ])),
                        RxInput(
                          isBorder: true,
                          readOnly: true,
                          data!.address,
                          labelText: "address".tr(),
                          // icon: const Icon(Icons.location_city),
                          onChanged: (v) => {data!.address = v},
                          validator: Validators.compose([
                            Validators.required("notempty.address.text".tr()),
                          ]),
                          onTap: _onAddress,
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                        ),
                        SizedBox(
                          height: 45,
                          child: DateTimePicker(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "birthday".tr(),
                            ),
                            // icon: const Icon(Icons.calendar_today),
                            locale: Locale("vi"),
                            initialValue:
                                CommonMethods.convertToDateTime(data!.birthdate)
                                    .toString(),
                            dateMask: 'dd-MM-yyyy',
                            firstDate: DateTime(1977),
                            lastDate: DateTime(2100),
                            onChanged: (value) => {data!.birthdate = value},
                          ),
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              _CustomRadioButton("male".tr(), "1"),
                              _CustomRadioButton("female".tr(), "0"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: RxPrimaryButton(
            onTap: () {
              if (_keyValidationForm.currentState!.validate()) {
                _onSave();
              }
            },
            text: 'save'.tr()),
      ),
    );
  }

  Widget _CustomRadioButton(String text, String value) {
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
}
