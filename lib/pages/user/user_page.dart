// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/dialogs/contact.dialog.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/user_provider.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/file.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
// ignore: unused_import
import 'package:raoxe/core/utilities/size_config.dart';
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
 
  loadData() async {
    try {
      ResponseModel res = await DaiLyXeApiBLL_APIUser().getuser();
      if (res.status > 0) {
        var user = UserModel.fromJson(jsonDecode(res.data));
        setState(() {
          data = user;
          urlImage = data!.rximg;
        });
        
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
        
        int idAvatar =
            await FileService().uploadImage(file, idFile: -1, name: data!.fullname!);
        // ignore: curly_braces_in_flow_control_structures
        if (data!.img != idAvatar) {
          var dataClone = data!.clone();
          dataClone.img = idAvatar;

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
              .setData(img: idAvatar);
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
    var res = await CommonNavigates.showDialogBottomSheet(
        context, ContactDialog(contact: data!.toContact()),
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
        backgroundColor: Theme.of(context).cardColor,
        body: data == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RxCustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                      expandedHeight: 250.0,
                      flexibleSpace: UserTopWidget(data, onUpload: onUpload)),
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Form(
                      key: _keyValidationForm,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text("fullname".tr(),
                                style: kTextTitleStyle),
                            subtitle: RxInput(data!.fullname!,
                                onChanged: (v) => {data!.fullname = v},
                                hintText: "fullname".tr(),
                                validator: Validators.compose([
                                  Validators.required(
                                      "notempty.fullname.text".tr()),
                                ])),
                          ),
                          ListTile(
                            title: Text("address".tr(),
                                style: kTextTitleStyle),
                            subtitle: RxInput(
                              readOnly: true,
                              data!.address!,
                              onChanged: (v) => {data!.address = v},
                              validator: Validators.compose([
                                Validators.required(
                                    "notempty.address.text".tr()),
                              ]),
                              onTap: _onAddress,
                              suffixIcon: Icon(AppIcons.chevron_right),
                            ),
                          ),
                          ListTile(
                            title: Text("birthday".tr(),
                                style: kTextTitleStyle),
                            subtitle: DateTimePicker(
                              locale: Locale("vi"),
                              initialValue: CommonMethods.convertToDateTime(
                                      data!.birthdate!)
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
                                _CustomRadioButton("male".tr(), 1),
                                _CustomRadioButton("female".tr(), 0),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
        persistentFooterButtons: [
          RxPrimaryButton(
              onTap: () {
                if (_keyValidationForm.currentState!.validate()) {
                  _onSave();
                }
              },
              text: 'save'.tr())
        ]);
  }

  Widget _CustomRadioButton(String text, dynamic value) {
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
