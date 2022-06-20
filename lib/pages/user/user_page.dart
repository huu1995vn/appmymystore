// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_primary_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';

import 'widgets/user_top.widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserModel? data;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    try {
      ResponseModel res = await DaiLyXeApiBLL_APIUser().getuser();
      if (res.status > 0) {
        setState(() {
          data = UserModel.fromJson(jsonDecode(res.data));
        });
      } else {
        CommonMethods.showToast(res.message);
      }
    } catch (e) {
      CommonMethods.showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      data==null?Expanded(child: RxCardSkeleton()):
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              expandedHeight: 250.0,
              flexibleSpace: UserTopWidget(data)),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Column(
                  children: [
                    RxBuildItem(
                        title: "fullname".tr(), trailing: Text(data!.fullname)),
                    RxBuildItem(
                        title: "address".tr(), trailing: Text(data!.address)),
                    RxBuildItem(
                        title: "birthday".tr(),
                        trailing: Text(CommonMethods.formatDateTime(
                            CommonMethods.convertToDateTime(data!.birthdate)))),
                    RxBuildItem(
                        title: "gender".tr(),
                        trailing: Text(
                          int.parse(data!.gender) == 1
                              ? "male".tr()
                              : "female".tr(),
                        )),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: SizedBox(
                      width: SizeConfig.screenWidth / 2,
                      child: RxPrimaryButton(
                        text: 'edit.text'.tr(),
                        onTap: () {},
                      ),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

//     Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.primary800,
//           elevation: 0.0,
//         ),
//         body: data == null
//             ? Container()
//             : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 UserTopWidget(data),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: SizeConfig.screenHeight / 34.15,
//                       ),
//                       RxBuildItem(
//                           title: "fullname".tr(),
//                           trailing: Text(data!.fullname)),
//                       RxBuildItem(
//                           title: "address".tr(), trailing: Text(data!.address)),
//                       RxBuildItem(
//                           title: "birthday".tr(),
//                           trailing: Text(CommonMethods.formatDateTime(
//                               CommonMethods.convertToDateTime(
//                                   data!.birthdate)))),
//                       RxBuildItem(
//                           title: "gender".tr(),
//                           trailing: Text(
//                             int.parse(data!.gender) == 1
//                                 ? "male".tr()
//                                 : "female".tr(),
//                           )),
//                     ],
//                   ),
//                 ),
//                 Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(kDefaultPadding),
//                     child: SizedBox(
//                       width: SizeConfig.screenWidth / 2,
//                       child: RxPrimaryButton(
//                         text: 'edit.text'.tr(),
//                         onTap: () {},
//                       ),
//                     ),
//                   ),
//                 )
//               ]));
//   }
// }
