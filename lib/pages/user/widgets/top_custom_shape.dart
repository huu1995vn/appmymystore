import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
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
      height: SizeConfig.screenHeight! / 2.78,
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: SizeConfig.screenHeight! / 4.78,
              color: AppColors.primary800,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    child: Align(
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
                    backgroundImage: NetworkImage(
                        CommonMethods.buildUrlHinhDaiDien(0,
                            rewriteUrl: "Huu")),
                  ),
                ),
                Text(
                  APITokenService.fullname,
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! / 136.6,
                ),
                Text("Đã xác thực",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      // fontSize: 24.0,
                    )),
                Text(
                  "email",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  "phone",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
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
