import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/utilities/extensions.dart';

class SaleComponent extends StatelessWidget {
  const SaleComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .26,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(CommonConstants.kDefaultRadius),
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  stops: [
                    0.2,
                    0.7
                  ],
                  colors: [
                    AppColors.primary,
                    Color(0xff79d2a6),
                  ]),
            ),
            height: MediaQuery.of(context).size.height * .26,
            padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
            child: Column(
              children: <Widget>[
                Text(
                  "Doanh thu hôm nay",
                  style: CommonConstants.kTextTitleStyle
                      .copyWith(color: AppColors.white),
                ),
                const SizedBox(height: CommonConstants.kDefaultPadding),
                Text(
                  r"$15,990.00 VND",
                  style: CommonConstants.kTextTitleStyle
                      .copyWith(color: AppColors.white, fontSize: 29),
                ),
                const SizedBox(height: CommonConstants.kDefaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Đơn hàng",
                        style: CommonConstants.kTextTitleStyle
                            .copyWith(color: AppColors.white)
                            .bold),
                  ],
                ),
                const SizedBox(height: CommonConstants.kDefaultPadding),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        height: 79,
                        color: Colors.black12,
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.black, //color of divider
                      width: 5, //width space of divider
                    ),
                    Expanded(
                      child: Container(
                        height: 79,
                        color: Colors.black12,
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.black, //color of divider
                      width: 5, //width space of divider
                    ),
                    Expanded(
                      child: Container(
                        height: 79,
                        color: Colors.black12,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
