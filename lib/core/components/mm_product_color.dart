// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/utilities/app_colors.dart';

class MMProductColor extends StatefulWidget {
  final EdgeInsetsGeometry margin, padding;
  final List<ColorModel> colors;
  const MMProductColor(this.margin, this.padding, this.colors, {super.key});
  @override
  _MMProductColorState createState() => _MMProductColorState();
}

class _MMProductColorState extends State<MMProductColor> {
  int _selectedIndex = -1;

  _change(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      child: Wrap(
        spacing: 20,
        runSpacing: 8,
        children: List.generate(
          widget.colors.length,
          (index) {
            return InkWell(
              onTap: () {
                _change(index);
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 2, color: AppColors.primarySoft), borderRadius: BorderRadius.circular(100)),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Color(widget.colors[index].code),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 4,
                      color: (index == _selectedIndex) ? AppColors.primarySoft.withOpacity(0.9) : Colors.transparent,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
