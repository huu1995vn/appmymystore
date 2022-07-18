// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:raoxe/core/api/dailyxe/dailyxe_api.bll.dart';
import 'package:raoxe/core/commons/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/components/part.dart';
import 'package:raoxe/core/components/rx_customscrollview.dart';
import 'package:raoxe/core/components/rx_sliverlist.dart';
import 'package:raoxe/core/entities.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/pages/main/home/widgets/item_product.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    loadData(paging);
  }

  int paging = 1;
  int totalItems = 0;
  List<ProductModel>? listData;
  AutoScrollController scrollController = AutoScrollController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  loadData([nPaging = 1]) async {
    if (nPaging > 1 && listData != null && totalItems <= listData!.length) {
      return;
    }

    try {
      nPaging = nPaging ?? 1;
      Map<String, dynamic> body = {"p": nPaging, "n": kItemOnPage};
      ResponseModel res = await DaiLyXeApiBLL_APIUser().favorite(body);
      if (res.status > 0) {
        List<ProductModel> list = CommonMethods.convertToList<ProductModel>(
            res.data, (val) => ProductModel.fromJson(val));
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
      } else {
        CommonMethods.showToast(context, res.message);
      }
    } catch (e) {
      CommonMethods.showDialogError(context, e.toString());
    }
  }

  Future<dynamic> onNextPage() async {
    return await loadData(paging + 1);
  }

  Future<dynamic> onRefresh() async {
    return await loadData(1);
  }

  @override
  dispose() {
    super.dispose();
    if (mounted) scrollController.dispose();
  }

  // onDelete(int index) async {
  //   try {
  //     var item = listData![index];
  //     CommonMethods.onFavorite([item!.id], !item!.isfavorite);
  //     listData!.removeAt(index);
  //   } catch (e) {
  //     CommonMethods.showDialogError(context, e);
  //   }
  // }

  // onDetail([int index = -1]) async {
  //   CommonNavigates.toFavoritePage(context, id: item.id);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _key,
      body: RxCustomScrollView(
        appBar: SliverAppBar(
          iconTheme: IconThemeData(
            color: AppColors.black, //change your color here
          ),
          centerTitle: true,
          title: Text('favorite'.tr(),
              style: kTextHeaderStyle.copyWith(color: AppColors.black)),
          backgroundColor: AppColors.grey,
          elevation: 0.0,
        ),
        key: const Key("LFavorite"),
        controller: scrollController,
        onNextScroll: onNextPage,
        onRefresh: onRefresh,
        slivers: <Widget>[
          RxSliverList(listData, (BuildContext context, int index) {
            ProductModel item = listData![index];
            return ItemProductWidget(item,
                onTap: () =>
                    {CommonNavigates.toFavoritePage(context, id: item.id)});
          })
        ],
      ),
      // persistentFooterButtons: [
      //   RxPrimaryButton(onTap: onDetail, text: "add.text".tr())
      // ],
    );
  }
}
