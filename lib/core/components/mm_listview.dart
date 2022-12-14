// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, non_constant_identifier_names

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:skeletons/skeletons.dart';

class MMListView extends StatefulWidget {
  final dynamic data;
  final Widget Function(BuildContext, int) itemBuilder;
  final Future<dynamic> Function()? onNextPage;
  final Future<dynamic> Function()? onRefresh;
  final Axis? scrollDirection;
  final ScrollController? scrollController;
  final Widget? awaiting;
  final Widget? noFound;
  final EdgeInsetsGeometry padding;
  const MMListView(this.data, this.itemBuilder,
      {Key? key,
      this.onNextPage,
      this.onRefresh,
      this.scrollController,
      this.scrollDirection,
      this.awaiting,
      this.noFound,
      this.padding = EdgeInsets.zero})
      : super(key: key);
  @override
  _MMDataListViewState createState() => _MMDataListViewState();
}

class _MMDataListViewState extends State<MMListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  _MMDataListViewState();
  ScrollController _scrollController = ScrollController();
  // ignore: prefer_final_fields
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool isLoading = false;
  @override
  initState() {
    super.initState();
    // if (mounted) {
    //   setState(() {
    //   });
    // }
    _scrollController = widget.scrollController ?? ScrollController();

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
    // try {
    //   if (_scrollController != null) {
    //     _scrollController.dispose();
    //   }
    // } catch (e) {}
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
        ? _bodylist(context)
        : RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => onRefresh(),
            child: _bodylist(context));
  }

  Widget _bodylist_awaiting() {
    return SizedBox(
        height: MediaQuery.of(context).size.height *
            (widget.scrollDirection == Axis.vertical ? 0.1 : 1),
        child: ListView.builder(
            key: UniqueKey(),
            shrinkWrap: true,
            controller:
                widget.scrollController != null ? null : _scrollController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: widget.scrollDirection ?? Axis.vertical,
            itemCount: CommonConstants.kItemOnPage,
            padding: widget.padding,
            itemBuilder: (context, index) {
              return widget.awaiting ??
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 16,
                        width: 64,
                        borderRadius: BorderRadius.circular(8)),
                  );
            }));
  }

  Widget _bodylist_notfound() {
    return Center(
        child: Container(
      padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
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
          ),
    ));
  }

  Widget _bodylist_main() {
    return ListView.builder(
      key: PageStorageKey(widget.key),
      shrinkWrap: true,
      controller: widget.scrollController != null ? null : _scrollController,
      physics: widget.scrollController != null
          ? const NeverScrollableScrollPhysics()
          : null,
      scrollDirection: widget.scrollDirection ?? Axis.vertical,
      itemCount: widget.onNextPage != null
          ? (widget.data.length + 1)
          : widget.data.length,
      padding: widget.padding,
      itemBuilder: (context, index) {
        if (index >= widget.data.length) {
          return _buildProgressIndicator();
        } else {
          return widget.itemBuilder(context, index);
        }
      },
    );
  }

  Widget _bodylist(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          key: UniqueKey(),
          shrinkWrap: true,
        ),
        (widget.data == null ||
                widget.itemBuilder == null ||
                widget.data is! List)
            ? _bodylist_awaiting()
            : widget.data.length == 0
                ? _bodylist_notfound()
                : _bodylist_main()
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Center(
      child: Opacity(
        opacity: (isLoading) ? 1.0 : 0.0,
        child: const CupertinoActivityIndicator(),
      ),
    );
  }
}
