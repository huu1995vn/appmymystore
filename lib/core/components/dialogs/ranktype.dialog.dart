// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, import_of_legacy_library_into_null_safe

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/data/ranktypes.dart';

class RankTypeDialog extends StatefulWidget {
  const RankTypeDialog({
    super.key,
  });
  @override
  State<RankTypeDialog> createState() => _RankTypeDialogState();
}

class _RankTypeDialogState extends State<RankTypeDialog>
    with TickerProviderStateMixin {
  List<RankTypeModel> data = rRankTypes;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: data.length, vsync: this);
  }

  TextStyle styleTitle =
      kTextHeaderStyle.copyWith(fontSize: 15, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // here the desired height
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              labelColor: Colors.black,
              controller: _tabController,
              indicator: BoxDecoration(color: AppColors.grayDark),
              tabs: [
                for (RankTypeModel item in data)
                  Tab(
                    icon: Icon(
                      AppIcons.diamond,
                      size: 30,
                      color: item.color,
                    ),
                    text: item.name,
                  ),
              ],
            ),
          )),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          for (var i = 0; i < data.length; i++)
            Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "discount".tr(),
                    ),
                    subtitle: Text(
                      "${CommonMethods.formatNumber(data[i].discount)} %",
                      style: const TextStyle().bold,
                    ),
                  ),
                  if (i != 0)
                    ListTile(
                      title: Text(
                        "Cần tích lũy",
                      ),
                      subtitle: Text(
                        "${CommonMethods.formatNumber(data[i].point)} point",
                        style: const TextStyle().bold,
                      ),
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
