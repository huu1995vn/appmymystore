// ignore_for_file: library_private_types_in_public_api

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/app_icons.dart';
import 'package:raoxe/core/commons/common_navigates.dart';
import 'package:raoxe/core/components/delegates/rx_search.delegate.dart';
import 'package:raoxe/core/components/dialogs/filter.dialog.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    super.key,
    required this.paramsSearch,
    required this.onChanged,
  });
  final Map<String, dynamic> paramsSearch;
  final void Function(Map<String, dynamic>) onChanged;
  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      controller.text = widget.paramsSearch["s"];
    });
  }

  @override
  void didUpdateWidget(SearchAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.paramsSearch["s"] != oldWidget.paramsSearch["s"] &&
        controller.text != widget.paramsSearch["s"]) {
      Future.delayed(Duration.zero, () {
        controller.text = widget.paramsSearch["s"];
      });
    }
  }

  _onSearch() async {
    var res = await showSearch(context: context, delegate: RxSearchDelegate());
    if (res != null) {
      widget.paramsSearch["s"] = res;

      widget.onChanged(widget.paramsSearch);
    }
  }

  _onFilter() async {
    var res = await CommonNavigates.openDialog(
        context, FilterDialog(searchParams: widget.paramsSearch));
    if (res != null) {
      setState(() {
        widget.onChanged(res);
      });
    }
  }

  int get numFillter {
    int nk = widget.paramsSearch.keys.length;
    if (widget.paramsSearch.keys.contains("s")) {
      nk--;
    }
    return nk;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(
                    AppIcons.magnifier,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  onPressed: _onSearch),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: TextField(
                    onTap: _onSearch,
                    readOnly: true,
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: "message.str014".tr,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    // style: kTextSubTitleStyle.copyWith(color: AppColors.black50),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: _onFilter,
                  child: Stack(
                    children: [
                      const IconButton(
                          icon: FaIcon(FontAwesomeIcons.filter),
                          onPressed: null),
                      if (numFillter > 0)
                        Positioned(
                            top: 0.0,
                            right: 3.0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.white50),
                                color: AppColors.grayDark,
                              ),
                              child: SizedBox(
                                  height: 20,
                                  width: 25,
                                  child: Center(
                                      child: Text(
                                    numFillter >= 9
                                        ? "9+"
                                        : numFillter.toString(),
                                    style: kTextSubTitleStyle.copyWith(
                                        color: AppColors.primary,
                                        fontStyle: FontStyle.normal),
                                  ))),
                            )),
                    ],
                  )),
            ],
          ),
        ));
  }
}
