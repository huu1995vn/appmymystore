// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_primary_button.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/components/rx_wrapper.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:raoxe/pages/user/widgets/item_child.dart';

import 'widgets/top_custom_shape.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  dynamic data = {
    "fullname": "Nguyễn Trọng Hữu",
    "email": "tronghuu271095@gmail.com",
    "phone": "0379.787.904",
    "fileid": 51307,
    "phonenumber": "0379787904",
    "username": "0379787904",
    "gender": true,
    "birthdate": "1970-01-01",
    "address": "113 Nguyễn Hữu Thọ, Quận Hải Châu, TP. Đà Nẵng",
    "verifyphone": true,
    "verifyemail": true
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TopCustomShape(),
      SizedBox(
        height: SizeConfig.screenHeight / 34.15,
      ),
      Expanded(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight / 34.15,
            ),
            ItemChild("fullname".tr(), value: data["fullname"]),
            RxDivider(),
            ItemChild("address".tr(), value: data["address"]),
            RxDivider(),
            ItemChild(
              "birthday".tr(),
              value: CommonMethods.formatDate(data["birthdate"], "dd/MM/yyyy"),
            ),
            RxDivider(),
            ItemChild(
              "gender".tr(),
              value: data["gender"] ? "male".tr() : "female".tr(),
            ),
          ],
        ),
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
    ]));
  }
}

//     return RxScaffold(
//         appBar: AppBar(
//           title: Text("",
//               style: TextStyle(
//                 color: kWhite,
//                 fontSize: 19,
//                 fontWeight: FontWeight.bold,
//               )),
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//         ),
//         child: Column(children: [
//           Container(
//               margin: EdgeInsets.all(16.0),
//               child: Stack(alignment: Alignment.topCenter, children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 30),
//                   child: Container(
//                     child: Column(children: [
//                       Center(
//                         child: Container(
//                           padding: EdgeInsets.only(top: 39.0),
//                           child: Text(
//                             "Đã xác thực",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               // fontSize: 24.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Container(
//                           padding: EdgeInsets.only(top: 8.0),
//                           child: Text(
//                             data["email"],
//                             style: TextStyle(
//                               fontSize: 12.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Container(
//                           padding: EdgeInsets.only(top: 8.0),
//                           child: Text(
//                             data["phone"],
//                             style: TextStyle(
//                               fontSize: 12.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                       ItemChild("fullname".tr(), value: data["fullname"]),
//                       RxDivider(),
//                       ItemChild("address".tr(), value: data["address"]),
//                       RxDivider(),
//                       ItemChild(
//                         "birthday".tr(),
//                         value: CommonMethods.formatDate(
//                             data["birthdate"], "dd/MM/yyyy"),
//                       ),
//                       RxDivider(),
//                       ItemChild(
//                         "gender".tr(),
//                         value: data["gender"] ? "male".tr() : "female".tr(),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(kDefaultPadding),
//                         child: SizedBox(
//                           width: SizeConfig.screenWidth / 2,
//                           child: RxPrimaryButton(
//                             text: 'edit.text'.tr(),
//                             onTap: () {},
//                           ),
//                         ),
//                       )
//                     ]),
//                     margin: EdgeInsets.only(
//                         top:
//                             16.0), // Change this based on the spacing between the card container and the avatar
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16.0),
//                     ),
//                   ),
//                 ),
//                 CircleAvatar(
//                   radius: 40.0,
//                   backgroundColor: Colors.white,
//                   child: CircleAvatar(
//                     child: Align(
//                       alignment: Alignment.bottomRight,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         radius: 12.0,
//                         child: Icon(
//                           Icons.camera_alt,
//                           size: 15.0,
//                           color: Color(0xFF404040),
//                         ),
//                       ),
//                     ),
//                     radius: 38.0,
//                     backgroundImage: NetworkImage(
//                         CommonMethods.buildUrlHinhDaiDien(data["fileid"],
//                             rewriteUrl: data["fullname"])),
//                   ),
//                 ),
//               ])),
//           Expanded(
//               child: Column(
//             children: [Container()],
//           ))
//         ]));
//   }
// }
