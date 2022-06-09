import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

class TopCustomShape extends StatefulWidget {
  const TopCustomShape({Key? key}) : super(key: key);

  @override
  _TopCustomShapeState createState() => _TopCustomShapeState();
}

class _TopCustomShapeState extends State<TopCustomShape> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! / 2.84,

      /// 240.0
      child: Stack(
        children: [
          // ClipPath(
          //   clipper: CustomShape(),
          //   child: Container(
          //     height: SizeConfig.screenHeight! / 4.56,
          //     decoration: kBoxDecorationStyle,
          //   ),
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: SizeConfig.screenHeight! / 4.88,

                  /// 140.0
                  width: SizeConfig.screenWidth! / 2.93,

                  /// 140.0
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white,
                          width: SizeConfig.screenWidth! / 51.37),
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(CommonMethods.buildUrlHinhDaiDien(
                              APITokenService.fileId,
                              rewriteUrl: APITokenService.fullname)))),
                ),
                Text(
                  APITokenService.fullname,
                  style: const TextStyle(fontSize: 22, color: AppColors.white)
                      .bold,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! / 136.6,
                ),

                /// 5.0
                // Text(
                //   "test@gmail.com",
                //   style: TextStyle(
                //       fontWeight: FontWeight.w400, color: Colors.black45),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}