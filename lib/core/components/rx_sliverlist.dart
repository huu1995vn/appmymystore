// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_null_comparison, non_constant_identifier_names, empty_catches

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/constants.dart';

class RxSliverList extends StatefulWidget {
  final dynamic data;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget? noFound;
  final Widget? awaiting;
  const RxSliverList(
    this.data,
    // ignore: invalid_required_positional_param
    @required this.itemBuilder, {
    Key? key,
    this.noFound,
    this.awaiting,
  }) : super(key: key);
  @override
  RxListViewState createState() => RxListViewState();
}

class RxListViewState extends State<RxSliverList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  RxListViewState();
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
          return Padding(
              padding: kEdgeInsetsPadding,
              child: widget.awaiting ??
                  RxCardSkeleton(
                      barCount: 3, isShowAvatar: false, isBorderRadius: true));
        },
        childCount: kItemOnPage,
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
                      EMPTYDATA,
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
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return widget.itemBuilder(context, index);
        },
        childCount: widget.data.length,
      ),
    );
  }

  Widget _bodylist() {
    return SliverPadding(
        padding: const EdgeInsets.all(kDefaultPadding),
        sliver: widget.data == null
            ? _bodylist_awaiting()
            : widget.data.length == 0
                ? _bodylist_notfound()
                : _bodylist_main());
  }
}
