import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/components/rx_scaffold.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/pages/home/components/search_bar.dart';
import 'package:easy_localization/easy_localization.dart';

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
          const SearchBar(),
          const SizedBox(
            height: 28,
          ),
          Expanded(
            child: RxWrapper(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // CategorySection(),
                    SizedBox(
                      height: 30,
                    ),
                    // ProductSlider(),
                    Padding(
                      padding: EdgeInsets.only(left: 42),
                      child: Text(
                        'Best Selling',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // BestSellingSection(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
