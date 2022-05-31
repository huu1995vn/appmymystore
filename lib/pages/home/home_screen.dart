import 'package:raoxe/core/components/index.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/core/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/pages/home/components/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: RxAppBar(
      //   title: Row(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: kDefaultPadding,
      //         ),
      //         child: RxRoundedButton(
      //           onTap: () {},
      //           icon: 'assets/icon.png',
      //         ),
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     InkWell(
      //       onTap: () {},
      //       child: Container(
      //         padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      //         child: SvgPicture.asset(
      //           'assets/icon.png',
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body: SizedBox(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 35,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text(
                'Explore your\nfavourite products',
                style: TextStyle(
                  color: kWhite,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const SearchBar(),
            const SizedBox(
              height: 28,
            ),
            Expanded(
              child: RxMainBody(
                child: SingleChildScrollView(
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
                            color: kPrimaryColor,
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
      ),
    );
  }
}
