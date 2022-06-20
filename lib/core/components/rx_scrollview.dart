// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_null_comparison, non_constant_identifier_names, empty_catches

import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class RxScrollView extends StatefulWidget {
  final dynamic data;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget? noFound;
  final Widget? awaiting;
  final int totalItems;
  final Future<dynamic> Function()? onNextPage;
  final Future<dynamic> Function()? onRefresh;
  final List<Widget>? slivers;
  final AutoScrollController controller;
  final SliverAppBar? appBar;
  final bool isDivider;

  const RxScrollView(
      this.data,
      // ignore: invalid_required_positional_param
      @required this.itemBuilder,
      this.totalItems,
      {Key? key,
      required this.controller,
      this.onNextPage,
      this.onRefresh,
      this.slivers,
      this.noFound,
      this.awaiting,
      this.isDivider = false,
      this.appBar})
      : super(key: key);
  @override
  RxListViewState createState() => RxListViewState();
}

class RxListViewState extends State<RxScrollView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  RxListViewState();
  late AutoScrollController scrollController;
  // ignore: prefer_final_fields
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool isLoading = false;

  @override
  initState() {
    super.initState();
    if (mounted)
      setState(() {
        scrollController = widget.controller;
      });
    if (widget.onNextPage != null && scrollController != null)
      scrollController.addListener(_scrollListener);
  }

  Future<void> onNextPage() async {
    if (widget.onNextPage != null) {
      await widget.onNextPage!();
    }
  }

  Future<void> onRefresh() async {
    if (widget.onRefresh != null) {
      await widget.onRefresh!();
    }
  }

  @override
  dispose() {
    super.dispose();
    if (widget.controller == null) {
      if (scrollController != null && mounted) scrollController.dispose();
    } 
    // else {
    //   if (mounted) {
    //     widget.controller.dispose();
    //   }
    // }
  }

  _scrollListener() async {
    try {
      var triggerFetchMoreSize =
          scrollController.position.maxScrollExtent - SizeConfig.screenHeight;
      if (scrollController.position.pixels > triggerFetchMoreSize) {
        if (mounted) setState(() => isLoading = true);
        if (isLoading) await onNextPage();
        if (mounted) setState(() => isLoading = false);
      }
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
  }

  @override
  Widget build(context) {
    super.build(context);
    return onRefresh == null
        ? _content(context)
        : RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => onRefresh(),
            child: _content(context));
  }

  Widget _wrapScrollTag({required int index, Widget? child}) => AutoScrollTag(
        key: ValueKey(index),
        controller: scrollController,
        index: index,
        child: child,
        // highlightColor: Colors.black.withOpacity(0.1),
      );
  Widget _content(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      key: widget.key ?? UniqueKey(),
      controller: scrollController,
      slivers: <Widget>[
        if (widget.appBar != null) widget.appBar!,
        if (widget.slivers != null)
          for (var item in widget.slivers!) item,
        _bodylist()
      ],
    );
  }

  Widget _bodylist_awaiting() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return widget.awaiting ??
              RxCardSkeleton(
                  barCount: 5, isShowAvatar: false, isBorderRadius: true);
        },
        childCount: kItemOnPage,
      ),
    );
  }

  Widget _bodylist_notfound() {
    return SliverToBoxAdapter(
        child: Container(
      padding: const EdgeInsets.all(20),
      child: widget.noFound ?? Text("notfound".tr()),
    ));
  }

  Widget _bodylist_main() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index >= widget.data.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.totalItems > widget.data.length
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Container(),
            );
          } else {
            return Column(
              children: <Widget>[
                _wrapScrollTag(
                    index: index, child: widget.itemBuilder(context, index)),
                if (widget.isDivider && index != widget.data.length - 1)
                  RxDivider()
              ],
            );
          }
        },
        childCount: widget.data.length + 1,
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
