// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_null_comparison, non_constant_identifier_names, empty_catches

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:skeletons/skeletons.dart';

class MMSliverList extends StatefulWidget {
  final dynamic data;
  final ViewType? viewType;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget? noFound;
  final Widget? awaiting;
  const MMSliverList(
    this.data,

    // ignore: invalid_required_positional_param
    @required this.itemBuilder, {
    Key? key,
    this.viewType,
    this.noFound,
    this.awaiting,
  }) : super(key: key);
  @override
  MMListViewState createState() => MMListViewState();
}

class MMListViewState extends State<MMSliverList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  MMListViewState();
  bool isLoading = false;

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(context) {
    super.build(context);
    return _bodylist();
  }

  Widget _bodylist_awaiting() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
              padding: CommonConstants.kEdgeInsetsPadding,
              color: Get.isDarkMode ? Colors.black : Colors.grey[200],
              child: widget.awaiting ??
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 16,
                        width: 64,
                        borderRadius: BorderRadius.circular(8)),
                  ));
        },
        childCount: CommonConstants.kItemOnPage,
      ),
    );
  }

  Widget _bodylist_notfound() {
    return SliverFillRemaining(
        hasScrollBody: true,
        child: widget.noFound ??
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.asset(
                      CommonConstants.IMAGE_EMPTY,
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    "no.found".tr,
                  ),
                ],
              ),
            ));
  }

  Widget _bodylist_main() {
    return (widget.viewType == ViewType.grid)
        ? SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 0.8,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return widget.itemBuilder(context, index);
              },
              childCount: widget.data.length,
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return widget.itemBuilder(context, index);
              },
              childCount: widget.data.length,
            ),
          );
  }

  Widget _bodylist() {
    return widget.data == null
        ? _bodylist_awaiting()
        : widget.data.length == 0
            ? _bodylist_notfound()
            : _bodylist_main();
  }
}
