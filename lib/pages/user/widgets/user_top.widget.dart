// ignore_for_file: sort_child_properties_last

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_rounded_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class UserTopWidget extends StatelessWidget {
  final UserModel? data;

  const UserTopWidget(this.data, {super.key});

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
                    backgroundColor: AppColors.white,
                    child: CircleAvatar(
                      child: const Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20.0,
                          child: Icon(
                            Icons.camera_alt,
                            size: 20.0,
                            color: Color(0xFF404040),
                          ),
                        ),
                      ),
                      radius: 60.0,
                      backgroundImage: RxImageProvider(data!.URLIMG),
                    ),
                  ),
                  Text(
                    APITokenService.fullname,
                    style:
                        const TextStyle(fontSize: 19, color: AppColors.white),
                  ),
                  RxRoundedButton(
                      onPressed: () {},
                      title: data!.VERIFY ? "verified".tr() : "Chưa xác thực",
                      color: data!.VERIFY ? AppColors.red : AppColors.warning),

                  Text(
                    data!.email,
                    style:
                        const TextStyle(color: AppColors.white),
                  ),
                  Text(
                    data!.phone,
                    style:
                        const TextStyle(color: AppColors.white),
                  )

                  // Container(
                  //   height: SizeConfig.screenHeight / 4.88,
                  //   width: SizeConfig.screenWidth / 2.93,

                  //   /// 140.0
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       border: Border.all(
                  //           color: Colors.white,
                  //           width: SizeConfig.screenWidth / 51.37),
                  //       color: Colors.white,
                  //       image: DecorationImage(
                  //           image: RxImageProvider(APITokenService.URLIMG))),
                  // ),
                  // Text(
                  //   APITokenService.fullname,
                  //   style: const TextStyle(fontSize: 22, color: AppColors.white)
                  //       .bold,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//     return SizedBox(
//       height: SizeConfig.screenHeight / 2.78,
//       child: Stack(
//         children: [
//           ClipPath(
//             clipper: RxCustomShape(),
//             child: Container(
//               height: SizeConfig.screenHeight / 4.78,
//               color: AppColors.primary800,
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 CircleAvatar(
//                   radius: 60.0,
//                   backgroundColor: Colors.white,
//                   child: CircleAvatar(
//                     child: const Align(
//                       alignment: Alignment.bottomRight,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         radius: 20.0,
//                         child: Icon(
//                           Icons.camera_alt,
//                           size: 20.0,
//                           color: Color(0xFF404040),
//                         ),
//                       ),
//                     ),
//                     radius: 60.0,
//                     backgroundImage: RxImageProvider(data!.URLIMG),
//                   ),
//                 ),
//                 Text(
//                   APITokenService.fullname,
//                   style: const TextStyle(fontSize: 22),
//                 ),
                
//                 RxRoundedButton(
//                     onPressed: () {},
//                     title: data!.VERIFY ? "verified".tr() : "Chưa xác thực",
//                     color: data!.VERIFY ? AppColors.red : AppColors.warning),
//                 Text(
//                   data!.email,
//                   style: const TextStyle(
//                     fontSize: 12.0,
//                   ),
//                 ),
//                 Text(
//                   data!.phone,
//                   style: const TextStyle(
//                     fontSize: 12.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

