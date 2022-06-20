import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class DashboardTopWidget extends StatefulWidget {
  const DashboardTopWidget({Key? key}) : super(key: key);

  @override
  DashboardTopWidgetState createState() => DashboardTopWidgetState();
}

class DashboardTopWidgetState extends State<DashboardTopWidget> {
  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: SizedBox(
        height: SizeConfig.screenHeight / 3.84,

        /// 240.0
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: SizeConfig.screenHeight / 4.88,
                    width: SizeConfig.screenWidth / 2.93,

                    /// 140.0
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white,
                            width: SizeConfig.screenWidth / 51.37),
                        color: Colors.white,
                        image: DecorationImage(
                            image: RxImageProvider(APITokenService.URLIMG))),
                  ),
                  Text(
                    APITokenService.fullname,
                    style: const TextStyle(fontSize: 22, color: AppColors.white)
                        .bold,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
