// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/api/dailyxe/index.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/delegates/rx_search.delegate.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_icon_button.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/pages/main/home/widgets/banner.widget.dart';
import 'package:raoxe/pages/product/widgets/list_brand.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../core/components/delegates/rx_select.delegate.dart';
import '../../../core/components/part.dart';
import '../../../core/services/app.service.dart';
import '../../../core/services/master_data.service.dart';
import 'widgets/item_product.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;
  final GlobalKey<FormState> _homeKey = GlobalKey<FormState>();
  AutoScrollController scrollController = AutoScrollController();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  String key = "LProcductHome";
  int paging = 1;
  int totalItems = 0;
  List<ProductModel>? listData;
  ViewType _viewType = ViewType.grid;
  Map<String, dynamic> paramsSearch = {};
  loadData([nPaging = 1]) async {
    if (nPaging > 1 && listData != null && totalItems <= listData!.length)
      return;
    try {
      nPaging = nPaging ?? 1;
      if (nPaging == 1) {
        setState(() {
          listData = null;
          totalItems = 0;
        });
      }
      Map<String, dynamic> params = {
        "p": nPaging,
        "n": kItemOnPage,
        "orderBy": "VerifyDate DESC"
      };
      ResponseModel res = await DaiLyXeApiBLL_APIGets().product(params);
      List<ProductModel> list = CommonMethods.convertToList<ProductModel>(
          res.data, (val) => ProductModel.fromJson(val));
      if (mounted)
        setState(() {
          if (nPaging == 1 && (list.isEmpty)) {
            totalItems = 0;
          }
          if (list.isNotEmpty) {
            totalItems = list[0].rxtotalrow;
          }
          listData ??= [];
          if (nPaging == 1) {
            listData = list;
          } else {
            listData = (listData! + list);
          }
        });
      paging = nPaging;
    } catch (e) {
      setState(() {
        listData = [];
        totalItems = 0;
      });
    }
  }

  _onSelectCity() async {
    List data = MasterDataService.data["city"];
    var res = await showSearch(
        context: context,
        delegate: RxSelectDelegate(data: data, value: paramsSearch['CityId']));
    if (res != null) {
      setState(() {
        paramsSearch['CityId'] = res;
        CommonNavigates.toProductPage(context, paramsSearch: {"CityId": res});
      });
    }
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  Future<dynamic> onRefresh() async {
    return await loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String cityName =
        CommonMethods.getNameMasterById("city", paramsSearch["CityId"]);
    return Scaffold(
      key: _homeKey,
      body: RxCustomScrollView(
        key: UniqueKey(),
        controller: scrollController,
        onNextScroll: onNextPage,
        onRefresh: onRefresh,
        appBar: _appBar(),
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Column(children: [
            const BannerWidget(),
            const SizedBox(height: kDefaultMarginBottomBox),
            Card(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPaddingBox, vertical: kDefaultPadding),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _onSelectCity();
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Get.isDarkMode
                                    ? Colors.white24
                                    : Colors.black12,
                              ),
                              borderRadius:
                                  BorderRadius.circular(5), //<-- SEE HERE
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPaddingBox,
                                  vertical: kDefaultPaddingBox),
                              child: Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.locationPin,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black26,
                                    size: 14,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("arena".tr,
                                      style: const TextStyle(fontSize: 13)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.caretDown,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black12,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ))),
                    GestureDetector(
                        onTap: () {
                          var _type = _viewType == ViewType.list
                              ? ViewType.grid
                              : ViewType.list;
                          AppService.saveViewTypeByKey(key, _type);
                          setState(() {
                            _viewType = _type;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPaddingBox),
                          child: Row(
                            children: [
                              Icon(
                                _viewType == ViewType.list
                                    ? AppIcons.grid_on
                                    : AppIcons.format_list_bulleted,
                                color: Get.isDarkMode
                                    ? Colors.white24
                                    : Colors.black26,
                                size: 23,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            ListBrandWidget(
                onPressed: (v) => {
                      CommonNavigates.toProductPage(context,
                          paramsSearch: {"BrandId": v})
                    }),
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(kDefaultPaddingBox),
                    child: _buildTitle("newpost".tr, () {
                      CommonNavigates.toProductPage(context);
                    }))),
          ])),
          RxSliverList(
            listData,
            (BuildContext context, int index) {
              ProductModel item = listData![index];
              return ItemProductWidget(
                item,
                viewType: _viewType,
                onTap: () {
                  CommonNavigates.toProductPage(context, item: item);
                },
              );
            },
            viewType: _viewType,
          )
        ],
      ),
    );
  }

  SliverAppBar _appBar() {
    return SliverAppBar(
      floating: true,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      leading: CommonMethods.isLogin
          ? Container(
              child: Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: RxIconButton(
                    onTap: () {
                      CommonNavigates.toFavoritePage(context);
                    },
                    icon: FontAwesomeIcons.bookmark,
                    size: 40,
                    color: Colors.transparent,
                    colorIcon: Colors.white,
                  )))
          : Container(),
      title: Container(
        alignment: Alignment.center,
        child: Image.asset(
          LOGORAOXEWHITEIMAGE,
          fit: BoxFit.contain,
          alignment: Alignment.center,
          height: 35,
        ),
      ),
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding),
            child: RxIconButton(
              onTap: _onSearch,
              icon: FontAwesomeIcons.search,
              size: 40,
              color: Colors.transparent,
              colorIcon: Colors.white,
            ))
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

_buildTitle(String header, void Function() onTap) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(header.toUpperCase(), style: const TextStyle(fontSize: 18).bold),
    RxButtonMore(
      text: "seemore".tr,
      onTap: onTap,
    ),
  ]);
}
