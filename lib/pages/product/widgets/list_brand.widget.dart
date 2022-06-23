// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';

class ListBrandWidget extends StatefulWidget {
  final int value;
  final void Function(int v) onPressed;
  const ListBrandWidget({super.key, required this.onPressed, required this.value});
  @override
  State<ListBrandWidget> createState() => _ListBrandWidgetState();
}

class _ListBrandWidgetState extends State<ListBrandWidget>
    with AutomaticKeepAliveClientMixin<ListBrandWidget> {
  @override
  bool get wantKeepAlive => true;
  static List<dynamic> data = MasterDataService.data["brand"] ?? [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 45,
      child: RxListView(
        data,
        (context, index) {
          var item = data[index];
          return Container(
            height: 35,
            margin: const EdgeInsets.only(right: 10),
            child: RxRoundedButton(
                color: widget.value == item["id"]
                    ? AppColors.primary
                    : AppColors.black50,
                onPressed: () {
                  widget.onPressed(item["id"]);
                },
                title: item["name"]),
          );
        },
        key: UniqueKey(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(kDefaultPadding).copyWith(bottom: 0),
      ),
    );
  }
}
