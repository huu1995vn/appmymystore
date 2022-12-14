// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mymystore/core/utilities/app_colors.dart';

enum Shape { Rectangle, Circular, None }

class MMTextAvatar extends StatelessWidget {
  Shape? shape;
  Color? backgroundColor;
  Color? textColor;
  double? size;
  final String? text;
  final double? fontSize;
  final int? numberLetters;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final bool? upperCase;
  final BoxBorder? border;
  MMTextAvatar(
      {super.key,
      @required this.text,
      this.textColor,
      this.backgroundColor,
      this.shape,
      this.numberLetters,
      this.size,
      this.fontWeight = FontWeight.bold,
      this.fontFamily,
      this.fontSize = 16,
      this.upperCase = false,
      this.border}) {
    //assert(numberLetters! > 0);
  }

  @override
  Widget build(BuildContext context) {
    shape = (shape == null) ? Shape.Rectangle : shape;
    size = (size == null || size! < 16) ? 16 : size;
    backgroundColor = backgroundColor ?? _colorBackgroundConfig();
    textColor = _colorTextConfig();
    return _textDisplay();
  }

  Color _colorBackgroundConfig() {
    if (RegExp(r'[A-Z]|').hasMatch(
      _textConfiguration(),
    )) {
      backgroundColor =
          colorData[_textConfiguration()[0].toLowerCase().toString()];
    }
    return backgroundColor ?? AppColors.primary;
  }

  Color _colorTextConfig() {
    if (textColor == null) {
      return Colors.white;
    } else {
      return textColor!;
    }
  }

  String _toString({String? value}) {
    return String.fromCharCodes(
      value!.runes.toList(),
    );
  }

  String _textConfiguration() {
    if(text == null || text!.isEmpty || text!.length == 0){
            return "?";
      }
      var newText = text == null ? '?' : _toString(value: text);
      newText = upperCase! ? newText.toUpperCase() : newText;
      var arrayLeeters = newText.trim().split(' ');

      if (arrayLeeters.length > 1 && arrayLeeters.length == numberLetters) {
        return '${arrayLeeters[0][0].trim()}${arrayLeeters[1][0].trim()}';
      }

      return newText[0];
  }

  Widget _buildText() {
    return Text(
      _textConfiguration().toUpperCase(),
      style: TextStyle(
        color: textColor,
        fontSize: size! / 2,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }

  // _buildTextType() {
  //   switch (shape) {
  //     case Shape.Rectangle:
  //       return RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(6.0),
  //       );
  //     case Shape.Circular:
  //       return RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(size! / 2),
  //       );
  //     case Shape.None:
  //       return RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(0.0),
  //       );
  //     default:
  //       {
  //         return RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(size! / 2),
  //         );
  //       }
  //   }
  // }

  Widget _textDisplay() {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: backgroundColor!.withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(size! / 2)),
        border: border ??
            Border.all(
              color: AppColors.white,
              width: 3.0,
            ),
      ),
      child: Center(
        child: _buildText(),
      ),
    );
    // Material(
    //   shape: _buildTextType(),
    //   color: backgroundColor,
    //   child: ,
    // );
  }
}

var colorData = {
  "a": const Color.fromRGBO(226, 95, 81, 1),
  "b": const Color.fromRGBO(242, 96, 145, 1),
  "c": const Color.fromRGBO(187, 101, 202, 1),
  "d": const Color.fromRGBO(149, 114, 207, 1),
  "e": const Color.fromRGBO(120, 132, 205, 1),
  "f": const Color.fromRGBO(91, 149, 249, 1),
  "g": const Color.fromRGBO(72, 194, 249, 1),
  "h": const Color.fromRGBO(69, 208, 226, 1),
  "i": const Color.fromRGBO(38, 166, 154, 1),
  "j": const Color.fromRGBO(82, 188, 137, 1),
  "k": const Color.fromRGBO(155, 206, 95, 1),
  "l": const Color.fromRGBO(212, 227, 74, 1),
  "m": const Color.fromRGBO(254, 218, 16, 1),
  "n": const Color.fromRGBO(247, 192, 0, 1),
  "o": const Color.fromRGBO(255, 168, 0, 1),
  "p": const Color.fromRGBO(255, 138, 96, 1),
  "q": const Color.fromRGBO(194, 194, 194, 1),
  "r": const Color.fromRGBO(143, 164, 175, 1),
  "s": const Color.fromRGBO(162, 136, 126, 1),
  "t": const Color.fromRGBO(163, 163, 163, 1),
  "u": const Color.fromRGBO(175, 181, 226, 1),
  "v": const Color.fromRGBO(179, 155, 221, 1),
  "w": const Color.fromRGBO(194, 194, 194, 1),
  "x": const Color.fromRGBO(124, 222, 235, 1),
  "y": const Color.fromRGBO(188, 170, 164, 1),
  "z": const Color.fromRGBO(173, 214, 125, 1),
};
