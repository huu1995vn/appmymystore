// ignore_for_file: sort_child_properties_last

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_rounded_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
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

        /// 240.0
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
                        child: GestureDetector(
                          onTap: onUpload,
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20.0,
                            child: Icon(
                              Icons.camera_alt,
                              size: 20.0,
                              color: Color(0xFF404040),
                            ),
                          ),
                        ),
                      ),
                      radius: 60.0,
                      backgroundImage: RxImageProvider(data!.URLIMG),
                    ),
                  ),
                  Text(
                    data!.fullname.toUpperCase(),
                    style:
                        const TextStyle(fontSize: 19, color: AppColors.white).bold,
                  ),
                  SizedBox(
                    height: 25,
                    child: RxRoundedButton(
                        onPressed: () {},
                        title: data!.VERIFY ? "verified".tr() : "Chưa xác thực",
                        color: data!.VERIFY ? AppColors.red : AppColors.warning),
                  ),
                  Text(
                    data!.email,
                    style: const TextStyle(color: AppColors.white),
                  ),
                  Text(
                    data!.phone,
                    style: const TextStyle(color: AppColors.white),
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
