import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/home/widgets/item_product.widget.dart';
import 'package:raoxe/pages/product/widgets/list_brand.widget.dart';
import 'package:raoxe/pages/product/widgets/search_app_bar.dart';
import '../../core/components/delegates/rx_select.delegate.dart';
import '../../core/services/master_data.service.dart';
import '../../core/utilities/app_colors.dart';

class ProductPage extends StatefulWidget {
  Map<String, dynamic>? paramsSearch;
  ProductPage({super.key, this.paramsSearch});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      paramsSearch = widget.paramsSearch ?? {};
      loadData();
    });
  }

  int paging = 1;
  int totalItems = 0;
  List<ProductModel>? listData;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _selectedCity = "";
  ViewType _viewType = ViewType.grid;
  Map<String, dynamic> paramsSearch = {};
  loadData([nPaging = 1]) async {
    if (listData != null && nPaging > 1 && totalItems <= listData!.length)
      // ignore: curly_braces_in_flow_control_structures
      return;
    paging = nPaging ?? 1;
    var body = <String, dynamic>{};
    body["p"] = paging;
    body["n"] = kItemOnPage;
    if (paramsSearch["s"] != null && paramsSearch["s"].length > 0) {
      body["s"] = paramsSearch["s"].toString().trim();
    }
    body["filter"] = getFilter();
    if (paramsSearch["OrderBy"] != null && paramsSearch["OrderBy"].length > 0) {
      body["orderBy"] = paramsSearch["OrderBy"].toString().trim();
    } else {
      body["orderBy"] = "VerifyDate DESC";
    }
    if (nPaging == 1) {
      setState(() {
        listData = null;
      });
    }
    ResponseModel res = await DaiLyXeApiBLL_APIGets().product(body);
    List<ProductModel> list = CommonMethods.convertToList<ProductModel>(
        res.data, (val) => ProductModel.fromJson(val));
    if (mounted) {
      setState(() {
        if (nPaging == 1 && (list.isEmpty)) {
          totalItems = 0;
        }
        if (list.isNotEmpty) {
          totalItems = list[0].rxtotalrow;
        }
        listData ??= [];
        if (paging == 1) {
          listData = list;
        } else {
          listData = (listData! + list);
        }
      });
    }
    paging = paging;
  }

  Future onNextPage() async {
    loadData(paging + 1);
  }

  Future onRefresh() async {
    loadData();
  }

  _onChanged(params) async {
    setState(() {
      paramsSearch = params;
      loadData();
    });
  }

  _onBrandChange(v) {
    setState(() {
      paramsSearch["BrandId"] = v;
      loadData();
    });
  }

  _onSelectCity() async {
    List data = MasterDataService.data["city"];
    var res = await showSearch(
        context: context,
        delegate: RxSelectDelegate(data: data, value: paramsSearch['CityId']));
    if (res != null) {
      setState(() {
        paramsSearch['CityId'] = res;
        loadData();
      });
    }
  }

  Map<String, dynamic> getFilter() {
    Map<String, dynamic> filter = <String, dynamic>{};
    List<String> keyfilters = [
      "BrandId",
      "State",
      "CityId",
      "ProductTypeId",
      "FuelType",
      "Year",
      "Seat",
      "Door",
      "Price"
    ];
    for (var key in keyfilters) {
      var value = paramsSearch[key];

      if (value == null) continue;
      if (key == "Price") {
        value = value
            .toString()
            .split(",")
            .map((e) => int.parse(e) * kStepPrice)
            .toList()
            .join(",");
      }
      filter[key] = value;
    }
    return filter;
  }

  @override
  Widget build(BuildContext context) {
    String cityName =
        CommonMethods.getNameMasterById("city", paramsSearch["CityId"]);
    return Scaffold(
        key: _key,
        // backgroundColor: Colors.white,
        body: RxCustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: SearchAppBar(
                paramsSearch: paramsSearch ?? {},
                onChanged: _onChanged,
              ),
              elevation: 0.0,
            ),
            SliverPadding(
                padding: const EdgeInsets.all(0),
                sliver: SliverToBoxAdapter(
                    child: Column(
                  children: [
                    Card(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPaddingBox),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      bottom: kDefaultPaddingBox),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.black12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            _onSelectCity();
                                          },
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: (CommonMethods
                                                              .convertToInt32(
                                                                  paramsSearch[
                                                                      "CityId"]) >
                                                          0)
                                                      ? AppColors.primary
                                                      : (Get.isDarkMode
                                                          ? Colors.white24
                                                          : Colors.black26),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5), //<-- SEE HERE
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            kDefaultPaddingBox,
                                                        vertical:
                                                            kDefaultPaddingBox),
                                                child: Row(
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .locationPin,
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Colors.black26,
                                                      size: 14,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        (cityName != null &&
                                                                cityName.length >
                                                                    0)
                                                            ? cityName
                                                            : "arena".tr,
                                                        style: const TextStyle(
                                                            fontSize: 13)),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .caretDown,
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Colors.black26,
                                                      size: 14,
                                                    ),
                                                  ],
                                                ),
                                              ))),
                                      GestureDetector(
                                          onTap: () {
                                            if (_viewType == ViewType.list) {
                                              _viewType = ViewType.grid;
                                            } else {
                                              _viewType = ViewType.list;
                                            }
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: kDefaultPaddingBox,
                                                vertical: kDefaultPaddingBox),
                                            child: Row(
                                              children: [
                                                FaIcon(
                                                  _viewType == ViewType.list
                                                      ? FontAwesomeIcons.thLarge
                                                      : FontAwesomeIcons.list,
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
                                )
                              ],
                            ))),
                    ListBrandWidget(
                        onPressed: (v) => {_onBrandChange(v)},
                        value: paramsSearch["BrandId"])
                  ],
                ))),
            RxSliverList(
              listData,
              (BuildContext context, int index) {
                var item = listData![index];
                return ItemProductWidget(
                  listData![index],
                  onTap: () {
                    CommonNavigates.toProductPage(context, item: item);
                  },
                  viewType: _viewType,
                );
              },
              viewType: _viewType,
            )
          ],
          key: const Key("LProcduct"),
          onNextScroll: onNextPage,
          onRefresh: onRefresh,
        ));
  }
}
