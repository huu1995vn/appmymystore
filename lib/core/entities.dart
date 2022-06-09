import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:raoxe/core/commons/common_methods.dart';

/// This allows the class to access private members in
/// the generated file called *.g.dart, where the star denotes the source file name.
part 'entities.g.dart';

class Entity {
  late String TotalRow;
  late String RowIndex;
}

/// An annotation for the code generator to know that this class needs
/// JSON serialization.
@JsonSerializable()
class ResponseModel {
  final dynamic data;
  final String message;
  final int status;
  ResponseModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}

@JsonSerializable()
class NewsModel extends Entity {
  late String id;
  late String type;
  late String img;
  late String name;
  late String desc;
  late String views;
  late String publishdate;
  late String prefix;
  late String url;
  late String webresourceid;
  late String webresourcename;
  late String webresourceurl;
  String get urlImg {
    int fileId = 0;
    if (img.isNotEmpty) {
      fileId = int.parse(img);
    }
    return CommonMethods.buildUrlHinhDaiDien(fileId, rewriteUrl: url);
  }

  NewsModel();
  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
@JsonSerializable()
class ProductModel extends Entity {
  late String id;
  late String type;
  late String img;
  late String name;
  late String desc;
  late String views;
  late String publishdate;
  late String prefix;
  late String url;
  late String webresourceid;
  late String webresourcename;
  late String webresourceurl;
  String get urlImg {
    int fileId = 0;
    if (img.isNotEmpty) {
      fileId = int.parse(img);
    }
    return CommonMethods.buildUrlHinhDaiDien(fileId, rewriteUrl: url);
  }

  ProductModel();
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
@JsonSerializable()
class UserModel {
  late String username = "";
  late String password = "";
  late String phone = "";
  UserModel();
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

class AppTheme {
  ThemeMode mode;
  String title;
  IconData icon;

  AppTheme({
    required this.mode,
    required this.title,
    required this.icon,
  });
}
