// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

import '../../../core/commons/common_methods.dart';
import '../../../core/components/rx_image.dart';
import '../../../core/utilities/size_config.dart';

class ListBrandWidget extends StatefulWidget {
  final int value;
  final void Function(int v) onPressed;
  const ListBrandWidget(
      {super.key, required this.onPressed, required this.value});
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
    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 6.0, color: Colors.black12),
        ),
      ),
      child: RxListView(
        data,
        (context, index) {
          var item = data[index];
          return InkWell(
              onTap: () {
                widget.onPressed(item["id"]);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: widget.value == item["id"]
                            ? AppColors.primary
                            : Colors.black26)),
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: RxImage(
                        CommonMethods.buildUrlHinhDaiDien(item["img"]),
                        width: 50,
                        height: 30,
                      ),
                    ),
                    Text(
                      item["name"],
                      style: TextStyle(fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ));
        },
        noFound: Container(),
        key: UniqueKey(),
        scrollDirection: Axis.horizontal,
        // padding: const EdgeInsets.all(kDefaultPadding).copyWith(bottom: 0),
      ),
    );
  }
}
