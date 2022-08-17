// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class UserTopWidget extends StatelessWidget {
  final UserModel? data;
  final void Function()? onUpload;
  const UserTopWidget(this.data, {super.key, this.onUpload});

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: const AssetImage('assets/loading_icon.gif'),
                    child: CircleAvatar(
                      // backgroundColor: Colors.white,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: 
                        RxIconButton(icon: AppIcons.camera_1, onTap: onUpload, size: 40,)
                        
                      ),
                      radius: 60.0,
                      backgroundImage: RxImageProvider(data!.rximg),
                    ),
                  ),
                  Text(
                    data!.fullname!.toUpperCase(),
                    style:
                        const TextStyle(fontSize: 19).bold,
                  ),
                  // SizedBox(
                  //   height: 25,
                  //   child: RxRoundedButton(
                  //       onPressed: () {},
                  //       title: data!.rxverify ? "verified".tr() : "unconfirmed".tr(),
                  //       color: data!.rxverify ? AppColors.red : AppColors.warning),
                  // ),
                  Text(
                    data!.email!,
                    // style: const TextStyle(color: AppColors.white),
                  ),
                  Text(
                    data!.phone!,
                    // style: const TextStyle(color: AppColors.white),
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
