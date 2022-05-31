import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raoxe/core/components/rx_rounded_button.dart';
import '../../../core/utilities/constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40.0,
              child: TextField(
                style: TextStyle(
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  hintText: 'search',
                  hintStyle: TextStyle(
                    color: kTextLightColor,
                    fontSize: 12,
                  ),
                  filled: true,
                  fillColor: kWhite,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 8,
                  ),
                  suffixIcon: SvgPicture.asset(
                    'assets/icon.png',
                    color: kPrimaryColor,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: kDefaultPadding / 2,
          ),
          RxRoundedButton(
            onTap: () {},
            icon: 'assets/icon.png',
          )
        ],
      ),
    );
  }
}
