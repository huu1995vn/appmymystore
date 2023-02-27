// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymystore/core/commons/common_methods.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/services/api_token.service.dart';

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
  String? email = "";
  String? address = "";
  int fileid = -1;
  String? get mmimg {
    return fileid >0? CommonMethods.buildUrlImage(fileid, rewriteUrl: name): null;
  }

  Widget avatar({double size = 16}) {
    return MMAvatar(name, url: mmimg, size: size);
  }

  UserModel();
  factory UserModel.fromJson(Map<String, dynamic> json) {
    json["name"] = CommonMethods.convertToString(json["name"]);
    json["phone"] = CommonMethods.convertToString(json["phone"]);
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["fileid"] = CommonMethods.convertToInt32(json["fileid"]);

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
  int fileid = -1;
  bool address = false;
  CustomerModel() {
    name;
    email;
    phone;
  }
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["fileid"] = CommonMethods.convertToInt32(json["fileid"]);
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
  int fileid = -1;
  String? material;
  String? color;
  String? size;
  int typeid = 1;
  String? note;
  DateTime? updatedate;
  DateTime? createdate;
  ProductModel();

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["fileid"] = CommonMethods.convertToInt32(json["fileid"]);
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
  
  String? get mmimg {
    return fileid >0? CommonMethods.buildUrlImage(fileid, rewriteUrl: name): null;
  }

  Widget avatar({double size = 16}) {
    return MMAvatar(name, url: mmimg, size: size);
  }

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

@JsonSerializable()
class ImportModel extends Entity {
  int id = 0;
  String name = "";
  int? promotion;
  int? count;
  int? total;
  DateTime? updatedate;
  DateTime? createdate;
  ImportModel();
  factory ImportModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["createdate"] =
        CommonMethods.convertToDateTime(json["createdate"])?.toIso8601String();
    json["updatedate"] =
        CommonMethods.convertToDateTime(json["updatedate"])?.toIso8601String();
 
    return _$ImportModelFromJson(json);
  }
  ImportModel clone() => ImportModel.fromJson(toJson());

  Map<String, dynamic> toJson() => _$ImportModelToJson(this);
  
}

@JsonSerializable()
class ExportModel extends Entity {
  int id = 0;
  String name = "";
  int? promotion;
  int? count;
  int? total;
  DateTime? updatedate;
  DateTime? createdate;
  ExportModel();
  factory ExportModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["createdate"] =
        CommonMethods.convertToDateTime(json["createdate"])?.toIso8601String();
    json["updatedate"] =
        CommonMethods.convertToDateTime(json["updatedate"])?.toIso8601String();
 
    return _$ExportModelFromJson(json);
  }
  ExportModel clone() => ExportModel.fromJson(toJson());

  Map<String, dynamic> toJson() => _$ExportModelToJson(this);
  
}

class SuggestionModel {
  bool isLocal = true;
  String text;
  SuggestionModel({required this.text, required this.isLocal});
}

class Categorie {
  int id;
  String categoryname;

  Categorie({required this.id, required this.categoryname});
}