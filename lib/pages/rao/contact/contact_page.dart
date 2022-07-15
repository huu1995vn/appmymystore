// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

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
import 'package:raoxe/pages/rao/contact/widgets/item_contact.widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
    loadData(paging);
  }

  int paging = 1;
  int totalItems = 0;
  List<ContactModel>? listData;
  AutoScrollController scrollController = AutoScrollController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  loadData([nPaging = 1]) async {
    if (nPaging > 1 && listData != null && totalItems <= listData!.length)
      return;

    try {
      nPaging = nPaging ?? 1;
      Map<String, dynamic> params = {"p": nPaging, "n": kItemOnPage};
      ResponseModel res = await DaiLyXeApiBLL_APIUser().contact(params);
      if (res.status > 0) {
        List<ContactModel> list = CommonMethods.convertToList<ContactModel>(
            res.data, (val) => ContactModel.fromJson(val));
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

  onDelete(int index) async {
    var item = listData![index];
    Map<String, dynamic> body = {
      "ids": [item.id]
    };
    ResponseModel res = await DaiLyXeApiBLL_APIUser().contactdelete(body);
    if (res.status > 0) {
      //call api dele
      setState(() {
        listData!.removeAt(index);
      });
    } else {
      CommonMethods.showToast(context, res.message);
    }
  }

  onDetail([int index = -1]) async {
    ContactModel item = index > 0 ? listData![index] : ContactModel();
    CommonNavigates.toContactPage(context,
        item: item,
        onChanged: (v) => {
              if (v.id > 0)
                {
                  setState(() {
                    listData![index] = v;
                  })
                }
              else
                {loadData()}
            });
  }

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
          title: Text('address'.tr(),
              style: kTextHeaderStyle.copyWith(color: AppColors.black)),
          backgroundColor: AppColors.grey,
          elevation: 0.0,
        ),
        key: const Key("LContact"),
        controller: scrollController,
        onNextScroll: onNextPage,
        onRefresh: onRefresh,
        slivers: <Widget>[
          RxSliverList(listData, (BuildContext context, int index) {
            ContactModel item = listData![index];
            return ItemContactWidget(item,
                onTap: () => {onDetail(index)},
                onDelete: (context) => onDelete(index));
          })
        ],
      ),
      persistentFooterButtons: [
        RxPrimaryButton(onTap: onDetail, text: "add.text".tr())
      ],
    );
  }
}
