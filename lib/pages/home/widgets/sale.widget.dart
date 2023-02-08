import 'package:flutter/material.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/utilities/extensions.dart';

class SaleWidget extends StatelessWidget {
  const SaleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .19,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(CommonConstants.kDefaultRadius),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  stops: const [
                    0.2,
                    0.7
                  ],
                  colors: [
                    AppColors.primary.withOpacity(0.86),
                    AppColors.primary,
                  ]),
            ),
            height: MediaQuery.of(context).size.height * .19,
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
                      .copyWith(color: AppColors.white, fontSize: 29).bold,
                ),
                const SizedBox(height: CommonConstants.kDefaultPadding * 2),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Spendings(name: "Đã thanh toán", amount: "1,500"),
                    Spendings(name: "Đang xử lý", amount: "1,500"),
                    Spendings(name: "Trả hàng", amount: "0")
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

class Spendings extends StatelessWidget {
  final String name;
  final String amount;
  const Spendings({
    super.key,
    required this.name,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(name,
            style: CommonConstants.kTextTitleStyle
                .copyWith(color: AppColors.white)),
        const SizedBox(height: CommonConstants.kDefaultPadding),
        Text(this.amount,
            style: CommonConstants.kTextSubTitleStyle
                .copyWith(color: AppColors.white)
                .bold),
      ],
    ));
  }
}
