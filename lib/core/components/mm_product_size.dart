// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mymystore/core/entities.dart';
import 'package:mymystore/core/utilities/app_colors.dart';

class MMProductSizeModel extends StatefulWidget {
  final List<SizeModel> sizes;
  final Color selectedColor;
  final Color baseColor;
  final TextStyle selectedTextStyle;
  final TextStyle textStyle;

  final EdgeInsetsGeometry margin, padding;
  const MMProductSizeModel(this.sizes, this.selectedColor, this.baseColor, this.selectedTextStyle, this.textStyle, this.margin, this.padding, {super.key}
  );

  @override
  _MMProductSizeState createState() => _MMProductSizeState();
}

class _MMProductSizeState extends State<MMProductSizeModel> {
  int _selectedIndex = -1;

  _change(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _getTextStyle(index) {
    if (index == _selectedIndex) {
      if (widget.selectedTextStyle == null) return TextStyle(color: Colors.white, fontWeight: FontWeight.w600);
      return widget.selectedTextStyle;
    } else {
      if (widget.textStyle == null) return TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600);
      return widget.textStyle;
    }
  }

  _getBackgroundColor(index) {
    if (index == _selectedIndex) {
      if (widget.selectedColor == null) return AppColors.secondary;
      return widget.selectedColor;
    } else {
      if (widget.baseColor == null) return AppColors.primarySoft;
      return widget.baseColor;
    }
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
          widget.sizes.length,
          (index) {
            return InkWell(
              onTap: () {
                _change(index);
              },
              child: Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _getBackgroundColor(index),
                ),
                child: Text(
                  '${widget.sizes[index].name}',
                  style: _getTextStyle(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
