// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/delegates/rx_search.delegate.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_images.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/theme_provider.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'widgets/item_product.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;
  final GlobalKey<FormState> _homeKey = GlobalKey<FormState>();
  AutoScrollController scrollController = AutoScrollController();

  @override
  void initState() {
    super.initState();
    loadData(paging);
  }

  int paging = 1;
  int totalItems = 0;
  List<ProductModel>? listData;
  loadData(nPaging) async {
    if (nPaging > 1 && listData != null && totalItems <= listData!.length)
      return;
    nPaging = nPaging ?? 1;
    Map<String, dynamic> params = {
      "p": nPaging,
      "n": kItemOnPage
    };
    ResponseModel res = await DaiLyXeApiBLL_APIGets().product(params);
    List<ProductModel> list = CommonMethods.convertToList<ProductModel>(
        res.data, (val) => ProductModel.fromJson(val));
    setState(() {
      totalItems = (nPaging == 1 && list.length == 0) ? 0 : list[0].rxtotalrow;
      listData;
      if (nPaging == 1) {
        listData = list;
      } else {
        listData = (listData! + list);
      }
    });
    paging = nPaging;
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  Future<dynamic> onRefresh() async {
    return await loadData(1);
  }

  onFavorite(int index) async {
    ProductModel item = listData![index];
    try {
      await CommonMethods.onFavorite([item.id], !item.isfavorite);
      setState(() {
        listData![index] = item;
      });
    } catch (e) {
      CommonMethods.showDialogError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      key: _homeKey,
      body: RxCustomScrollView(
        key: const Key("lHome"),
        controller: scrollController,
        onNextScroll: onNextPage,
        onRefresh: onRefresh,
        appBar: _appBar(),
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Column(children: [
              const RxImages(data: []),
            _buildTitle("new".tr(), () {
              CommonNavigates.toProductPage(context);
            }),
          ])),
          RxSliverList(listData, (BuildContext context, int index) {
            ProductModel item = listData![index];
            return ItemProductWidget(
              item,
              onTap: () {
                CommonNavigates.toProductPage(context, id: item.id);
              },
              onFavorite: () => {onFavorite(index)},
            );
          })
        ],
      ),
    );
  }

  SliverAppBar _appBar() {
    final theme = Provider.of<ThemeProvider>(context);
    return SliverAppBar(
      floating: true,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: Container(child: null),
      title: Container(
        alignment: Alignment.center,
        child: Image.asset(
          theme.selectedThemeMode.name == "dark"
              ? LOGORAOXEWHITEIMAGE
              : LOGORAOXECOLORIMAGE,
          fit: BoxFit.contain,
          alignment: Alignment.center,
          height: 35,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: kDefaultPadding),
          child: GestureDetector(
              onTap: () {},
              child: Ink(
                decoration: const ShapeDecoration(
                  color: AppColors.grayDark,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  iconSize: 17,
                  icon: const Icon(AppIcons.magnifier),
                  color: AppColors.primary,
                  onPressed: () => {_onSearch()},
                ),
              )),
        )
      ],
    );
  }

  _onSearch() async {
    var res = await showSearch(context: context, delegate: RxSearchDelegate());
    if (res != null) {
      CommonNavigates.toProductPage(context, paramsSearch: {"s": res});
    }
  }
}

_buildTitle(String header, void Function()? onTap) {
  return Padding(
    padding:
        const EdgeInsets.only(right: kDefaultPadding, left: kDefaultPadding),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(header.toUpperCase(),
          style: const TextStyle(color: AppColors.primary).bold),
      GestureDetector(
        onTap: onTap,
        child: Ink(
          decoration: const ShapeDecoration(
            color: AppColors.grayDark,
            shape: CircleBorder(),
          ),
          child: const Icon(
            AppIcons.chevron_right,
            size: 30,
            color: AppColors.primary,
          ),
        ),
      )
    ]),
  );
}
