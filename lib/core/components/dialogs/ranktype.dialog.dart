// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously, import_of_legacy_library_into_null_safe

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/entities.dart';
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

class _RankTypeDialogState extends State<RankTypeDialog> {
  List<RankTypeModel> data = rRankTypes;

  @override
  void initState() {
    super.initState();
  }

  TextStyle styleTitle =
      kTextHeaderStyle.copyWith(fontSize: 15, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 2, color: Colors.grey.shade500))),
          height: 70,
          child: TabBar(
            indicator: BoxDecoration(color: Colors.grey[100]),
            tabs: [
              for (RankTypeModel item in data)
                Tab(
                  icon: Icon(
                    AppIcons.polymer,
                    size: 30,
                  ),
                  text: item.name,
                ),
            ],
          ),
        ),
        SizedBox(
          height: 170,
          child: TabBarView(
            children: <Widget>[
              for (var i = 0; i < data.length; i++)
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (i == 0) Text("message.str037".tr()),
                      if (i != 0)
                        Text(
                          "message.p014".tr(args: [data[i].name]),
                          style: const TextStyle().bold,
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (i != 0)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            Text(
                              "discount".tr(),
                            ),
                            Text(
                              CommonMethods.formatNumber(data[i].discount) +
                                  "%",
                              style: const TextStyle().bold,
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (i != 0)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            const Text(
                              "Cần tích lũy: ",
                            ),
                            Text(
                              CommonMethods.formatNumber(data[i].point) +
                                  " point",
                              style: const TextStyle().bold,
                            ),
                          ],
                        ),
                    ],
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
