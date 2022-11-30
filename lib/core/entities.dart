// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/providers/app_provider.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/utilities/constants.dart';

/// This allows the class to access private members in
/// the generated file called *.g.dart, where the star denotes the source file name.
part 'entities.g.dart';

class Entity {
  dynamic TotalRow;
  dynamic RowIndex;
  int get rxtotalrow {
    return CommonMethods.convertToInt32(TotalRow);
  }

  int get rxrowindex {
    return CommonMethods.convertToInt32(RowIndex);
  }
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

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    json["status"] = CommonMethods.convertToInt32(json["status"]);
    json["message"] = CommonMethods.convertToString(json["message"]);
    return _$ResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}

@JsonSerializable()
class UserModel extends Entity {
  int id = APITokenService.id;
  String name = "";
  String phone = "";
  late String email = "";
  late String address = "";
  String? image;
  String get mmimage {
    return image ?? '$kIconPath/me.png';
  }

  UserModel();
  factory UserModel.fromJson(Map<String, dynamic> json) {
    json["name"] = CommonMethods.convertToString(json["name"]);
    json["phone"] = CommonMethods.convertToString(json["phone"]);
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    return _$UserModelFromJson(json);
  }

  UserModel clone() => UserModel.fromJson(toJson());
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class CustomerModel extends Entity {
  int id = -1;
  String? name;
  String? phone;
  String? email;
  String? image;
  bool address = false;
  CustomerModel() {
    name;
    email;
    phone;
  }
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return _$CustomerModelFromJson(json);
  }

  CustomerModel clone() => CustomerModel.fromJson(toJson());
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}

@JsonSerializable()
class ProductModel extends Entity {
  int id = 0;
  String name = "";
  String code = "";
  int? promotion;
  bool ispercentpromotion = false;
  int? price;
  int? amountexport;
  int? amountimport;
  String? image;
  String? material;
  String? color;
  String? size;
  int typeid = 1;
  String? note;
  DateTime? updatedate;
  DateTime? createdate;
  ProductModel();
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    json["createdate"] =
        CommonMethods.convertToDateTime(json["createdate"])?.toIso8601String();
    json["updatedate"] =
        CommonMethods.convertToDateTime(json["updatedate"])?.toIso8601String();
    json["ispercentpromotion"] =
        CommonMethods.convertToBoolean(json["ispercentpromotion"]);

    return _$ProductModelFromJson(json);
  }
  ProductModel clone() => ProductModel.fromJson(toJson());

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
  // Products.ProductTypeId
  //  + 1: Ban
  //  + 2: Mua

  // Products.State // tạm bỏ qua mạc định là
  //  + 1: Moi
  //  + 2: Da su dung
  // Products.Status
  //  + 1: Tao moi
  //  + 2: Da duyet
  //  + 3: Khong duyet
  //  + 4: Vi pham (Khoa)

  String get mmcreatedateago {
    return CommonMethods.timeagoFormat(createdate);
  }

  String get mmprice {
    try {
      return CommonMethods.formatShortCurrency(price);
    } catch (e) {
      return "not.update".tr;
    }
  }
}

class SuggestionModel {
  bool isLocal = true;
  String text;
  SuggestionModel({required this.text, required this.isLocal});
}
