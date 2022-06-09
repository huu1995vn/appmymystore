import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/rx_data_listview.dart';
import 'package:raoxe/core/components/rx_listview.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/providers/theme_provider.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:raoxe/pages/main/home/widgets/item_product_highlight.widget.dart';
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
  final _androidRefreshKey = GlobalKey<RefreshIndicatorState>();
  GlobalKey<FormState> _homeKey = GlobalKey<FormState>();
  AutoScrollController scrollController = AutoScrollController();

  void initState() {
    super.initState();
    loadData(paging);
  }

  int paging = 1;
  int totalItems = 0;
  List<ProductModel> listData = <ProductModel>[];
  loadData(nPaging) async {
    nPaging = nPaging ?? 1;
    Map<String, dynamic> params = {
      "id": 2, // cái này là lại ParentIdList === tin tức mới
      "p": paging,
      "n": kItemOnPage
    };
    ResponseModel res = await DaiLyXeApiBLL_Page().news(params);
    List<dynamic> data = jsonDecode(res.data["newslist"]);
    List<ProductModel> newslist = data
        .map((val) => ProductModel.fromJson(val))
        .toList() as List<ProductModel>;
    setState(() {
      totalItems = newslist.isNotEmpty ? int.parse(newslist[0].TotalRow) : 0;
      listData ??= [];
      if (nPaging == 1) {
        listData = newslist;
      } else {
        listData = (listData! + newslist)!;
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

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: _homeKey,
      body: RxListView(
        listData,
        (BuildContext context, int index) {
          return ItemProductWidget(listData![index]);
        },
        totalItems,
        key: const Key("lHome"),
        padding: const EdgeInsets.all(kDefaultPadding),
        controller: scrollController,
        onNextPage: onNextPage,
        onRefresh: onRefresh,
        appBar: SliverAppBar(
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
              height: 40,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: kDefaultPadding),
              child: Ink(
                decoration: const ShapeDecoration(
                  color: AppColors.grayDark,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  iconSize: 25,
                  icon: const Icon(Icons.search),
                  color: AppColors.black,
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Column(children: [
            _buildHeader("Nổi bật", () {}),
            SizedBox(
                height: (SizeConfig.screenHeight / 4) + 28,
                child: RxDataListView(listData, (context, index) {
                  return ItemProductHighlightWidget(listData[index]);
                }, scrollDirection: Axis.horizontal)),
            _buildHeader("Phổ biến", () {}),
          ]))
        ],
      ),
    );
  }
}

_buildHeader(String _header, void Function()? onTap) {
  return Padding(
    padding:
        const EdgeInsets.only(right: kDefaultPadding, left: kDefaultPadding),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(_header.toUpperCase(), style: const TextStyle().bold),
      GestureDetector(
        onTap: () {},
        child: Ink(
          decoration: const ShapeDecoration(
            color: AppColors.grayDark,
            shape: CircleBorder(),
          ),
          child: IconButton(
            iconSize: 25,
            icon: const Icon(Icons.forward_outlined),
            color: AppColors.black,
            onPressed: () {},
          ),
        ),
      )
    ]),
  );
}