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
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40.0,
              child: TextField(
                style: const TextStyle(
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  hintText: 'search',
                  hintStyle: const TextStyle(
                    color: kTextLightColor,
                    fontSize: 12,
                  ),
                  filled: true,
                  fillColor: kWhite,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
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
          const SizedBox(
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
