// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';

class RxDataListView extends StatefulWidget {
  final dynamic data;
  final Widget Function(BuildContext, int) itemBuilder;
  final Future<dynamic> Function()? onNextPage;
  final Future<dynamic> Function()? onRefresh;
  final Axis? scrollDirection;
  final ScrollController? scrollController;
  const RxDataListView(this.data, this.itemBuilder,
      {Key? key,
      this.onNextPage,
      this.onRefresh,
      this.scrollController,
      this.scrollDirection})
      : super(key: key);
  @override
  _RxDataListViewState createState() => _RxDataListViewState();
}

class _RxDataListViewState extends State<RxDataListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  _RxDataListViewState();
  ScrollController _scrollController = ScrollController();
  // ignore: prefer_final_fields
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool isLoading = false;
  @override
  initState() {
    super.initState();
    if (mounted) {
      setState(() {
        _scrollController = widget.scrollController ?? ScrollController();
      });
    }
    if (widget.onNextPage != null) {
      _scrollController.addListener(_scrollListener);
    }
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
    if (_scrollController != null) _scrollController.dispose();
  }

  _scrollListener() async {
    if (!isLoading) {
      var triggerFetchMoreSize = _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels == triggerFetchMoreSize) {
        if (mounted) setState(() => isLoading = true);
        if (isLoading) await onNextPage();
        if (mounted) setState(() => isLoading = false);
      }
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
    return (widget.data == null ||
            widget.itemBuilder == null ||
            widget.data is! List)
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RxCardSkeleton(barCount: 5, isShowAvatar: false)
             
            ],
          ))
        : widget.data.length == 0
            ? Text("notfound".tr(),
                style: const TextStyle(color: AppColors.primary))
            : ListView.builder(
                key: PageStorageKey(widget.key),
                shrinkWrap: true,
                controller:
                    widget.scrollController != null ? null : _scrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: widget.scrollDirection ?? Axis.vertical,
                itemCount: widget.onNextPage != null
                    ? (widget.data.length + 1)
                    : widget.data.length,
                padding: const EdgeInsets.all(kDefaultPadding),
                itemBuilder: (context, index) {
                  if (index >= widget.data.length) {
                    return _buildProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        widget.itemBuilder(context, index),
                        // if (widget.isDivider && index != widget.data.length - 1)
                        //   RxDivider()
                      ],
                    );
                  }
                },
              );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: (isLoading) ? 1.0 : 0.0,
          child: const CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
