// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_null_comparison, non_constant_identifier_names, empty_catches

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class RxCustomScrollView extends StatefulWidget {
  final List<Widget>? slivers;
  final AutoScrollController? controller;
  final SliverAppBar? appBar;
  final Future<dynamic> Function()? onNextScroll;
  final Future<dynamic> Function()? onRefresh;
  const RxCustomScrollView(
      {super.key,
      this.controller,
      this.slivers,
      this.appBar,
      this.onNextScroll,
      this.onRefresh});
  @override
  RxListViewState createState() => RxListViewState();
}

class RxListViewState extends State<RxCustomScrollView>
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
        scrollController = widget.controller ?? AutoScrollController();
      });
    if (widget.onNextScroll != null && scrollController != null)
      scrollController.addListener(_scrollListener);
  }

  @override
  dispose() {
    super.dispose();
    if (widget.controller == null) {
      if (scrollController != null && mounted) scrollController.dispose();
    }
  }

  Future<void> onRefresh() async {
    if (widget.onRefresh != null) {
      await widget.onRefresh!();
    }
  }

  _scrollListener() async {
    try {
      var triggerFetchMoreSize =
          scrollController.position.maxScrollExtent - (SizeConfig.screenHeight/3);
      if (widget.onNextScroll != null && !isLoading &&
          scrollController.position.pixels > triggerFetchMoreSize) {
        isLoading = true;
        await widget.onNextScroll!();
        isLoading = false;
      }
    } catch (e) {
      CommonMethods.wirtePrint(e);
      if (mounted) setState(() => isLoading = false);
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

  Widget _content(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      key: widget.key ?? UniqueKey(),
      controller: scrollController,
      slivers: <Widget>[
        if (widget.appBar != null) widget.appBar!,
        if (widget.slivers != null)
          for (var item in widget.slivers!) item,
      ],
    );
  }
}
