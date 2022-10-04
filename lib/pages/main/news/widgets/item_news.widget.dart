// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';

import '../../../../core/providers/theme_provider.dart';

class ItemNewsWidget extends StatelessWidget {
  final NewsModel item;
  void Function()? onTap;
  ItemNewsWidget(this.item, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isDark =
        Provider.of<ThemeProvider>(context).selectedThemeMode.name == 'dark';
    return Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: InkWell(
                onTap: onTap,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenWidth * 0.566,
                        child: RxImage(
                          item.rximg,
                          fit: BoxFit.cover,
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(item.webresourcename,
                                  style:
                                      const TextStyle(color: AppColors.orange),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(Icons.fiber_manual_record,
                                    size: 5, color: Colors.grey[500])),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(item.rxtimeago,
                                  style: kTextTimeStyle.copyWith(
                                      color: isDark
                                          ? Colors.white54
                                          : Colors.grey)),
                            ),
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(item.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18).bold)),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(item.desc,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ]),
                    )
                  ],
                ))));
  }
}
