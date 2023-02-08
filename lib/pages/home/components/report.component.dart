// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
import 'package:mymystore/core/utilities/extensions.dart';

class ReportComponent extends StatelessWidget {
  ReportComponent({
    super.key,
  });
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "-1", child: Text("Tất cả")),
      const DropdownMenuItem(value: "1", child: Text("Hôm nay")),
      const DropdownMenuItem(value: "2", child: Text("7 ngày qua")),
      const DropdownMenuItem(value: "3", child: Text("Tháng này")),
      const DropdownMenuItem(value: "3", child: Text("Tháng trước")),
      const DropdownMenuItem(value: "4", child: Text("Năm nay")),
      const DropdownMenuItem(value: "5", child: Text("Năm trước")),
    ];
    return menuItems;
  }

  String selectedValue = "-1";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .19,
      child: Padding(
        padding: const EdgeInsets.all(CommonConstants.kDefaultPadding),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Thống kê",
                  style: CommonConstants.kTextTitleStyle.bold,
                ),
                DropdownButton(
                  value: selectedValue,
                  items: dropdownItems,
                  onChanged: (Object? value) {},
                ),
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Spendings(name: "Tổng đơn", amount: "1,000"),
                MMVerticalDivider(
                  height: 50,
                ),
                Spendings(name: "Doanh thu", amount: r"$15,990.00 VND"),
                MMVerticalDivider(
                  height: 50,
                ),
                Spendings(name: "Lợi nhuận", amount: r"$15,990.00 VND")
              ],
            ),
          ],
        ),
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
        Text(name, style: CommonConstants.kTextTitleStyle),
        const SizedBox(height: CommonConstants.kDefaultPadding),
        Text(this.amount, style: CommonConstants.kTextSubTitleStyle.bold),
      ],
    ));
  }
}
