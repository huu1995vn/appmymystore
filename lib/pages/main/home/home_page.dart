import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/utilities/app_colors.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raoxe/core/utilities/extensions.dart';
import 'package:raoxe/pages/main/home/widgets/cars.widget.dart';
import 'package:raoxe/pages/main/home/widgets/cars_highlight.widget.dart';
import 'package:raoxe/pages/main/home/widgets/search.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RxScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: const Text(
              'hello',
              style: TextStyle(
                color: kWhite,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
          ),
          const SizedBox(
            height: 7,
          ),
          const SearchWidget(),
          const SizedBox(
            height: 28,
          ),
          Expanded(
            child: RxWrapper(
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("highlight".tr().toUpperCase(),
                              style: const TextStyle().bold),
                          GestureDetector(
                              onTap: () {},
                              child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 0),
                                  child: Text("seemore".tr(),
                                      style: const TextStyle()
                                          .textColor(Colors.blue)
                                          .italic)))
                        ]),
                  ),
                  CarsHighlightWidget(),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cars".toUpperCase(),
                              style: const TextStyle().bold),
                          GestureDetector(
                              onTap: () {},
                              child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 0),
                                  child: Text("seemore".tr(),
                                      style: const TextStyle()
                                          .textColor(Colors.blue)
                                          .italic)))
                        ]),
                  ),
                  CarsWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
