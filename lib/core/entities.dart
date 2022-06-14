// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/services/api_token.service.dart';

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
  late int id;
  late String type;
  late int img;
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
    if (img != null) {
      fileId = img;
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
  late int id;
  late int img;
  late int cityid;
  late int districtid;
  late String username;
  late String password;
  late String identitynumber;
  late String fullname;
  late String jobtitle;
  late bool gender = true;
  late DateTime birthdate;
  late String email;
  late String phone;
  late String phonenumber;
  late String address;
  late String note;
  late int status = 1;
  UserModel();
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  Map<String, dynamic> toInsert() => <String, dynamic>{
        'id': -1,
        'fields': <String>[
          "FileId",
          "CityId",
          "DistrictId",
          "UserName",
          "Password",
          "IdentityNumber",
          "FullName",
          "JobTitle",
          "BirthDate",
          "Gender",
          "Email",
          "Phone",
          "PhoneNumber",
          "Address"
        ],
        'datas': <dynamic>[
          img,
          cityid,
          districtid,
          username,
          password,
          identitynumber,
          jobtitle,
          birthdate,
          gender,
          email,
          phone,
          phonenumber,
          address
        ],
      };
  Map<String, dynamic> toUpdate() => <String, dynamic>{
        'id': APITokenService.userId,
        'fields': <String>[
          "FileId",
          "CityId",
          "DistrictId",
          "IdentityNumber",
          "FullName",
          "JobTitle",
          "BirthDate",
          "Gender",
          "Address"
        ],
        'datas': <dynamic>[
          img,
          cityid,
          districtid,
          identitynumber,
          jobtitle,
          birthdate,
          gender,
          address
        ],
      };
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
