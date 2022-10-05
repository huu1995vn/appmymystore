// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/services/master_data.service.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import '../../../core/commons/common_methods.dart';
import '../../../core/components/rx_image.dart';

class ListBrandWidget extends StatefulWidget {
  final int? value;
  final void Function(int v) onPressed;
  const ListBrandWidget({super.key, required this.onPressed, this.value});
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
    return Card(
        margin: const EdgeInsets.only(bottom: kDefaultMarginBottomBox),
        child: Padding(
            padding: const EdgeInsets.all(kDefaultPaddingBox),
            child: SizedBox(
              height: 43,
              child: RxListView(
                data,
                (context, index) {
                  var item = data[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: GestureDetector(
                        onTap: () {
                          widget.onPressed(item["id"]);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: BorderSide(
                                  width: 1,
                                  color: widget.value == item["id"]
                                      ? AppColors.primary
                                      : Colors.black26)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 60,
                                height: 30,
                                child: RxImage(
                                  CommonMethods.buildUrlHinhDaiDien(
                                      item["img"]),
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
                        )),
                  );
                },
                noFound: Container(),
                key: UniqueKey(),
                scrollDirection: Axis.horizontal,
              ),
            )));
  }
}
