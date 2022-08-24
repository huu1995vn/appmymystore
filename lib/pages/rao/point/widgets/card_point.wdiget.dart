// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/dialogs/ranktype.dialog.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';

class CardPointBuild extends StatefulWidget {
  final PointModel data;
  const CardPointBuild({Key? key, required this.data}) : super(key: key);

  @override
  _CardPointBuildState createState() => _CardPointBuildState();
}

class _CardPointBuildState extends State<CardPointBuild> {
  _onInfo()
  {
    CommonNavigates.showDialogBottomSheet(context, const RankTypeDialog(), height: 250);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    PointModel data = widget.data;
    RankTypeModel rantype = data.ranktype;
    Color fontColor = AppColors.black;
    Color bgColor = data.ranktype.color;
    return Container(
      height: 200,
      // width: size.width * 0.8,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // ignore: prefer_const_literals_to_create_immutables
          stops: [
            0.1,
            1,
            0.6,
            1
          ],
          colors: [
            bgColor,
            AppColors.white,
            bgColor,
            AppColors.grey,
          ],
        ),
        // color: AppColors.info,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07,
                    vertical: size.height * 0.03,
                  ),
                  child: Text(
                    'Total point',
                    style: kTextHeaderStyle.bold,
                  ),
                ),
                Center(
                  child: Text(
                    "${CommonMethods.formatNumber(data.totalpoint)}",
                    style: kTextPriceStyle.copyWith(fontSize: 18, color: AppColors.success),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.07,
                            vertical: size.height * 0.03,
                          ),
                          child: Text(
                            'Current point',
                            style: TextStyle(
                              color: fontColor.withOpacity(0.8),
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "${CommonMethods.formatNumber(data.currentpoint)}",
                            style: kTextSubTitleStyle,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.07,
                            vertical: size.height * 0.03,
                          ),
                          child: Text(
                            'Used point',
                            style: TextStyle(
                              color: fontColor.withOpacity(0.8),
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "${CommonMethods.formatNumber(data.usedpoint)}",
                            style: kTextSubTitleStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                  horizontal: size.width * 0.05,
                ),
                child: SizedBox(
                  height: size.height * 0.03,
                  width: size.width * 0.6,
                  child: Text(
                    rantype.name,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inconsolata(
                      color: fontColor,
                      fontSize: size.height * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: RxIconButton(
                    icon: AppIcons.question_circle,
                    onTap: _onInfo,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
