// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              height: 55,
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
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                    width: 1,
                                    color: widget.value == item["id"]
                                        ? AppColors.primary
                                        : Colors.black12)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 70,
                                          height: 30,
                                          child: RxImage(
                                            CommonMethods.buildUrlImage(
                                                item["img"], rewriteUrl: item["name"]),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          item["name"],
                                          style: TextStyle(fontSize: 10),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                    if (widget.value == item["id"])
                                      Positioned(
                                          top: -10,
                                          right: -15,
                                          child: RotationTransition(
                                            turns: new AlwaysStoppedAnimation(
                                                45 / 360),
                                            child: Container(
                                              width: 40,
                                              height: 20,
                                              color: AppColors.primary,
                                            ),
                                          )),
                                    if (widget.value == item["id"])
                                      Positioned(
                                          top: 1,
                                          right: 1,
                                          child: Container(
                                            child: const FaIcon(
                                              FontAwesomeIcons.check,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          )),
                                  ],
                                ))),
                      ));
                },
                noFound: Container(),
                key: UniqueKey(),
                scrollDirection: Axis.horizontal,
              ),
            )));
  }
}
