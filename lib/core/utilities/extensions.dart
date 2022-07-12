// ignore_for_file: empty_catches, unnecessary_null_comparison, depend_on_referenced_packages, unnecessary_type_check

library extension_rao;

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/utilities/app_colors.dart';

extension StringExtension on String {
  int getIdFile() {
    var str = this;
    if (Uri.parse(str).isAbsolute) {
      RegExpMatch? match = RegExp(r"-(\d*)j\d*\.").firstMatch(str);
      var idFile = match!.group(1);
      if (idFile != null) return int.parse(idFile);
    }
    return -1;
  }

  String toUcfirst() {
    var str = this;
    str = str.toLowerCase();
    return str[0].toUpperCase() + str.substring(1);
  }

  bool get isNotNullEmpty {
    return this != null && isNotEmpty;
  }

  bool get isNullEmpty {
    return this == null || isEmpty;
  }

  bool isNumberPhone() {
    var str = this;
    final regExpNumberPhone = RegExp(r"0[1-9]\d{8}$");
    return regExpNumberPhone.hasMatch(str);
  }

  bool isStringNumber() {
    var str = this;
    final regExpStringNumber = RegExp(r"\d");
    return regExpStringNumber.hasMatch(str);
  }

  bool isEmail() {
    var str = this;
    final regExpEmail =
        RegExp(r"^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$");
    return regExpEmail.hasMatch(str);
  }

  String convertrUrlPrefix() {
    var str = this;
    try {
      str = str
          .toASCII()
          .toLowerCase()
          .replaceAll(RegExp("[\u0300-\u036f]"), '')
          .replaceAll("đ", 'd')
          .replaceAll(RegExp("/+"), ' ')
          .replaceAll(RegExp("\\?+"), '')
          .replaceAll(RegExp(" +"), "-");
    } catch (e) {}
    return str;
  }

  String toASCII() {
    var str = this;
    if (str == null || (str.isEmpty)) return "";
    try {
      String vietnamese = "aAeEoOuUiIdDyY";
      List<RegExp> vietnameseRegex = <RegExp>[
        RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
        RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
        RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
        RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
        RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
        RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
        RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
        RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
        RegExp(r'ì|í|ị|ỉ|ĩ'),
        RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
        RegExp(r'đ'),
        RegExp(r'Đ'),
        RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
        RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
      ];
      String result = str;
      if (result is String) {
        for (int i = 0; i < vietnamese.length; ++i) {
          result = result.replaceAll(vietnameseRegex[i], vietnamese[i]);
        }
      }
      return result;
    } catch (e) {
      // CommonMethods.wirtePrint(e);
    }
    return str;
  }

  String toListString({bool removeBrackets = false}) {
    dynamic list = this;
    String data = "";
    try {
      if (list != null) {
        data = list.toString();
      }
      if (removeBrackets) {
        data = data.replaceAll("[", "").replaceAll("]", "");
      }
    } catch (e) {}
    return data;
  }

  List<int> toListInt() {
    String str = this;
    try {
      if (str.isNotEmpty) {
        var l = str.split(',');
        return List<int>.from(l.map((data) => int.parse(data)).toList());
      }
    } catch (e) {
      // CommonMethods.wirtePrint(e);
    }
    return [];
  }

  String formartContent() {
    var str = this ?? "";
    if (CommonMethods.isMobile()) {
      return str!.replaceAllMapped(
          RegExp(r'((\u0023|\u002a|[\u0030-\u0039])\ufe0f\u20e3){1}'),
          (match) => match[2]!);
    }
    return str;
  }
}

extension ListDynamicExtension on List<dynamic> {
  List<int> getListId([String atrr = "Id"]) {
    var list = this;
    List<int> listId = <int>[];
    try {
      for (var item in list) {
        int id;
        try {
          id = item.toJson()[atrr];
        } catch (e) {
          id = item[atrr];
        }
        listId.add(id);
      }
    } catch (e) {}
    return listId;
  }

  List<Map> toListMap() {
    var list = this;
    List<Map> data = [];
    try {
      for (var item in list) {
        data.add(item.toJson());
      }
    } catch (e) {}
    return data;
  }

  bool get haveValue {
    var list = this;
    return list != null && list.isNotEmpty;
  }
}

extension ListFileExtension on List<File> {
  List<String> getListPath() {
    List<File> list = this;
    List<String> listPath = <String>[];
    try {
      for (var item in list) {
        if (item.path.isNotNullEmpty) {
          listPath.add(item.path);
        }
      }
    } catch (e) {}
    return listPath;
  }

  List clone() {
    return [...this];
  }
}

extension MapExtension on Map {
  Map clone() {
    return json.decode(json.encode(this));
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle get thin => weight(FontWeight.w100);
  TextStyle get extraLight => weight(FontWeight.w200);
  TextStyle get light => weight(FontWeight.w300);
  TextStyle get regular => weight(FontWeight.normal);
  TextStyle get medium => weight(FontWeight.w500);
  TextStyle get semiBold => weight(FontWeight.w600);
  TextStyle get bold => weight(FontWeight.w700);
  TextStyle get normal => weight(FontWeight.normal);
  TextStyle get extraBold => weight(FontWeight.w800);
  TextStyle get black => copyWith(color: Colors.black);

  /// Shortcut for italic
  TextStyle get italic => style(FontStyle.italic);

  /// Shortcut for underline
  TextStyle get underline => textDecoration(TextDecoration.underline);

  /// Shortcut for linethrough
  TextStyle get lineThrough => textDecoration(TextDecoration.lineThrough);

  /// Shortcut for overline
  TextStyle get overline => textDecoration(TextDecoration.overline);

  /// Shortcut for color
  TextStyle textColor(Color v) => copyWith(color: v);

  /// Shortcut for backgroundColor
  TextStyle textBackgroundColor(Color v) => copyWith(backgroundColor: v);

  /// Shortcut for fontSize

  TextStyle size(double v) => copyWith(fontSize: v);

  /// Scales fontSize up or down
  TextStyle scale(double v) => copyWith(fontSize: fontSize! * v);

  /// Shortcut for fontWeight
  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  /// Shortcut for FontStyle
  TextStyle style(FontStyle v) => copyWith(fontStyle: v);

  /// Shortcut for letterSpacing
  TextStyle letterSpace(double v) => copyWith(letterSpacing: v);

  /// Shortcut for wordSpacing
  TextStyle wordSpace(double v) => copyWith(wordSpacing: v);

  /// Shortcut for textBaseline
  TextStyle baseline(TextBaseline v) => copyWith(textBaseline: v);

  /// Shortcut for height
  TextStyle textHeight(double v) => copyWith(height: v);

  /// Shortcut for locale
  TextStyle textLocale(Locale v) => copyWith(locale: v);

  /// Shortcut for foreground
  TextStyle textForeground(Paint v) => copyWith(foreground: v);

  /// Shortcut for background
  TextStyle textBackground(Paint v) => copyWith(background: v);

  /// Shortcut for shadows
  TextStyle textShadows(List<Shadow> v) => copyWith(shadows: v);

  /// Shortcut for fontFeatures
  TextStyle textFeatures(List<FontFeature> v) => copyWith(fontFeatures: v);

  /// Shortcut for decoration
  TextStyle textDecoration(TextDecoration v,
          {Color? color, TextDecorationStyle? style, double? thickness}) =>
      copyWith(
          decoration: v,
          decorationColor: color,
          decorationStyle: style,
          decorationThickness: thickness);

  /// Shortcut for opacity
  TextStyle textOpacity(double opacity) =>
      copyWith(color: color?.withOpacity(opacity));

  TextStyle get textRequired => copyWith(color: AppColors.danger).bold;
}

// ignore: camel_case_extensions
extension intExtension on int {
  //Hàm chuẩn hóa thành hàm đại điện nhỉ gọn
  String compact({String def = ""}) {
    if (this == null) {
      return def;
    }
    try {
      final number = this;
      final result = (NumberFormat.compact(locale: "vi")).format(number);
      return result;
    } catch (e) {}
    return def;
  }
}

extension ListExtension on List {
  bool equals(List list) {
    return every((item) => list.contains(item));
  }

  List clone<T>() {
    return List<T>.from(this);
  }
}

const _epochTicks = 621355968000000000;

extension Ticks on DateTime {
  int get ticks => microsecondsSinceEpoch * 10 + _epochTicks;
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  if(list==null) return result;
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}