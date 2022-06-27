// ignore_for_file: non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/services/api_token.service.dart';

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
    return _$ResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}

@JsonSerializable()
class NewsModel extends Entity {
  late int id;
  late int type;
  late int img;
  late String name;
  late String desc;
  late int views;
  late String publishdate;
  late String prefix;
  late String url;
  late String webresourceid;
  late String webresourcename;
  late String webresourceurl;
  String get rxlink {
    return CommonMethods.buildUrlNews(id, prefixUrl: prefix, rewriteUrl: url);
  }

  String get rxtimeago {
    return CommonMethods.timeagoFormat(
        CommonMethods.convertToDateTime(publishdate));
  }

  String get rximg {
    int fileId = 0;
    fileId = img;
    return CommonMethods.buildUrlHinhDaiDien(fileId, rewriteUrl: url);
  }

  NewsModel();
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["type"] = CommonMethods.convertToInt32(json["type"], 1);
    json["img"] = CommonMethods.convertToInt32(json["img"]);
    json["views"] = CommonMethods.convertToInt32(json["views"]);
    return _$NewsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}

@JsonSerializable()
class NotificationModel extends Entity {
  int id = 0;
  int notificationtypeid = 1;
  String subject;
  String message;
  DateTime? createdate;
  NotificationModel({
    required this.id,
    required this.notificationtypeid,
    required this.subject,
    required this.message,
    required this.createdate,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["notificationtypeid"] =
        CommonMethods.convertToInt32(json["notificationtypeid"]);
    json["createdate"] = CommonMethods.convertToDateTime(json["createdate"]);
    return _$NotificationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class UserModel extends Entity {
  int id = 0;
  int img = 0;
  int cityid = 0;
  int districtid = 0;
  String? username;
  String? password;
  String? identitynumber;
  String? fullname;
  String? jobtitle;
  int gender = 1;
  String? birthdate;
  String? email;
  String? phone;
  String? phonenumber;
  bool verifyphone = false;
  bool verifyemail = false;
  String? address;
  String? note;
  int status = 1;
  UserModel() {
    username;
    password;
    email;
    phone;
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["notificationtypeid"] =
        CommonMethods.convertToInt32(json["notificationtypeid"]);
    json["gender"] = CommonMethods.convertToInt32(json["gender"]);
    json["status"] = CommonMethods.convertToInt32(json["status"]);
    json["verifyphone"] = CommonMethods.convertToBoolean(json["verifyphone"]);
    json["verifyemail"] = CommonMethods.convertToBoolean(json["verifyemail"]);
    return _$UserModelFromJson(json);
  }
  ContactModel toContact() {
    ContactModel contact = ContactModel();
    contact.fullname = fullname;
    contact.address = address;
    contact.cityid = cityid;
    contact.districtid = districtid;
    return contact;
  }

  UserModel clone() => UserModel.fromJson(toJson());
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  String get rximg {
    try {
      int fileId = 0;
      fileId = img;
      return CommonMethods.buildUrlHinhDaiDien(fileId, rewriteUrl: fullname);
    } catch (e) {
      CommonMethods.wirtePrint(e);

      return "";
    }
  }

  bool get rxverify {
    return verifyphone && verifyemail;
  }

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
          fullname,
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
          fullname,
          jobtitle,
          birthdate,
          gender,
          address
        ],
      };
}

@JsonSerializable()
class ProductModel extends Entity {
  int id = 0;
  int userid = 0;
  int imguser = 0;
  String? username;
  int usercontactid = 0;
  String? usercontactname;
  String? usercontactphone;
  String? usercontactemail;
  String? usercontactaddress;
  int brandid = 0;
  String? brandname;
  int modelid = 0;
  String? modelname;
  int bodytypeid = 0;
  String? bodytypename;
  int fueltypeid = 0;
  String? fueltypename;
  int madeinid = 0;
  String? madeinname;
  int colorid = 0;
  String? colorname;
  int cityid = 0;
  String? cityname;
  int producttypeid = 1;
  String? producttypename;
  int img = 0;
  String? imglist;
  String? name;
  String? description;
  int price = 0;
  String? year;
  String? seat;
  String? door;
  String? km;
  int state = 1;
  int views = 0;
  double ratingvalue = 0;
  int reviewcount = 0;
  int review1 = 0;
  int review2 = 0;
  int review3 = 0;
  int review4 = 0;
  int review5 = 0;
  String? keywordsearch;
  int status = 1;
  DateTime? verifydate;
  DateTime? createdate;

  ProductModel();
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["userid"] = CommonMethods.convertToInt32(json["userid"]);
    json["imguser"] = CommonMethods.convertToInt32(json["imguser"]);
    json["usercontactid"] = CommonMethods.convertToInt32(json["usercontactid"]);
    json["brandid"] = CommonMethods.convertToInt32(json["brandid"]);
    json["modelid"] = CommonMethods.convertToInt32(json["modelid"]);
    json["bodytypeid"] = CommonMethods.convertToInt32(json["bodytypeid"]);
    json["fueltypeid"] = CommonMethods.convertToInt32(json["fueltypeid"]);
    json["madeinid"] = CommonMethods.convertToInt32(json["madeinid"]);
    json["colorid"] = CommonMethods.convertToInt32(json["colorid"]);
    json["cityid"] = CommonMethods.convertToInt32(json["cityid"]);
    json["producttypeid"] = CommonMethods.convertToInt32(json["producttypeid"], 1);
    json["img"] = CommonMethods.convertToInt32(json["img"]);
    json["price"] = CommonMethods.convertToInt32(json["price"]);
    json["state"] = CommonMethods.convertToInt32(json["state"], 1);
    json["views"] = CommonMethods.convertToInt32(json["views"], 1);
    json["ratingvalue"] = CommonMethods.convertToDouble(json["ratingvalue"]);
    json["reviewcount"] = CommonMethods.convertToInt32(json["reviewcount"]);
    json["status"] = CommonMethods.convertToInt32(json["status"], 1);
    json["review1"] = CommonMethods.convertToInt32(json["review1"]);
    json["review2"] = CommonMethods.convertToInt32(json["review2"]);
    json["review3"] = CommonMethods.convertToInt32(json["review3"]);
    json["review4"] = CommonMethods.convertToInt32(json["review4"]);
    json["review5"] = CommonMethods.convertToInt32(json["review5"]);
    json["verifydate"] = CommonMethods.convertToDateTime(json["verifydate"]);
    json["verifydate"] = CommonMethods.convertToDateTime(json["verifydate"]);
    return _$ProductModelFromJson(json);
  }

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

  String get rxtimeago {
    return CommonMethods.timeagoFormat(verifydate);
  }

  String get rxprice {
    try {
      return NumberFormat.decimalPattern().format(price);
    } catch (e) {
      return "Liên hệ";
    }
  }

  String get rximguser {
    try {
      return CommonMethods.buildUrlHinhDaiDien(imguser, rewriteUrl: name);
    } catch (e) {
      CommonMethods.wirtePrint(e);

      return "";
    }
  }

  String get rximg {
    try {
      return CommonMethods.buildUrlHinhDaiDien(img, rewriteUrl: name);
    } catch (e) {
      CommonMethods.wirtePrint(e);

      return "";
    }
  }

  List<String> get rximglist {
    try {
      return imglist!
          .split(",")
          .map((e) =>
              CommonMethods.buildUrlHinhDaiDien(int.parse(e), rewriteUrl: name))
          .toList();
    } catch (e) {
      CommonMethods.wirtePrint(e);
      return [];
    }
  }

  Map<String, dynamic> toInsert() => <String, dynamic>{
        'id': -1,
        'fields': <String>[
          "UserId",
          "UserContactId",
          "BrandId",
          "ModelId",
          "BodyTypeId",
          "FuelTypeId",
          "MadeInId",
          "ColorId",
          "CityId",
          "ProductTypeId",
          "FileId",
          "FileIdList",
          "ProductName",
          "Description",
          "Price",
          "Year",
          "Seat",
          "Door",
          "KM",
          "State",
        ],
        'datas': <dynamic>[
          userid,
          usercontactid,
          brandid,
          modelid,
          bodytypeid,
          fueltypeid,
          madeinid,
          colorid,
          cityid,
          producttypeid,
          img,
          imglist,
          name,
          description,
          price,
          year,
          seat,
          door,
          km,
          state,
        ],
      };
  Map<String, dynamic> toUpdate(id) => <String, dynamic>{
        'id': id,
        'fields': <String>[
          "UserId",
          "UserContactId",
          "BrandId",
          "ModelId",
          "BodyTypeId",
          "FuelTypeId",
          "MadeInId",
          "ColorId",
          "CityId",
          "ProductTypeId",
          "FileId",
          "FileIdList",
          "ProductName",
          "Description",
          "Price",
          "Year",
          "Seat",
          "Door",
          "KM",
          "State",
        ],
        'datas': <dynamic>[
          userid,
          usercontactid,
          brandid,
          modelid,
          bodytypeid,
          fueltypeid,
          madeinid,
          colorid,
          cityid,
          producttypeid,
          img,
          imglist,
          name,
          description,
          price,
          year,
          seat,
          door,
          km,
          state,
        ],
      };
}

@JsonSerializable()
class AdvertModel extends Entity {
  int id = 0;
  String? code;
  int img = 0;
  int userid = 0;
  int adverttypeid = 0;
  int referenceid = 0;
  String? regionname;
  String? displayName;
  String? jobtitle;
  String? phone;
  String? email;
  String? name;
  int price = 0;
  String? discountprice;
  String? saleprice;
  String? discount;
  DateTime? expirationdate;
  DateTime? reminderdate;
  String? note;
  int status = 1;
  String? adverttypename;
  String? adminname;

  String get rxprice {
    try {
      return NumberFormat.decimalPattern().format(price);
    } catch (e) {
      return "Liên hệ";
    }
  }

  String get rximg {
    return CommonMethods.buildUrlHinhDaiDien(img, rewriteUrl: name);
  }

  AdvertModel();
  factory AdvertModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["img"] = CommonMethods.convertToInt32(json["img"]);
    json["userid"] = CommonMethods.convertToInt32(json["userid"]);
    json["adverttypeid"] = CommonMethods.convertToInt32(json["adverttypeid"]);
    json["referenceid"] = CommonMethods.convertToInt32(json["referenceid"]);
    json["price"] = CommonMethods.convertToInt32(json["price"]);
    json["status"] = CommonMethods.convertToInt32(json["price"], 1);
    json["expirationdate"] =
        CommonMethods.convertToDateTime(json["expirationdate"], "dd/MM/yyyy");
    json["reminderdate"] =
        CommonMethods.convertToDateTime(json["reminderdate"], "dd/MM/yyyy");
    return _$AdvertModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AdvertModelToJson(this);
}

@JsonSerializable()
class ContactModel extends Entity {
  int id = 0;
  int userid = APITokenService.userId;
  int cityid = 0;
  String? cityname;
  int districtid = 0;
  String? districtname;
  String? fullname;
  String? phone;
  String? address;
  bool isdefault = false;
  UserModel clone() => UserModel.fromJson(toJson());
  ContactModel();
  bool get rxisdefault {
    return isdefault == "true";
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["userid"] =
        CommonMethods.convertToInt32(json["userid"], APITokenService.userId);
    json["cityid"] = CommonMethods.convertToInt32(json["cityid"]);
    json["districtid"] = CommonMethods.convertToInt32(json["districtid"]);
    json["isdefault"] = CommonMethods.convertToBoolean(json["isdefault"]);

    return _$ContactModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}

@JsonSerializable()
class ProductReviewsModel extends Entity {
  int id = 0;
  int userid = APITokenService.userId;
  String? username;
  int productid = 0;
  String? comment;
  int reviewcount = 0;
  int ratingvalue = 0;
  DateTime? createdate;
  ProductReviewsModel();
  String get rxtimeago {
    return CommonMethods.timeagoFormat(createdate);
  }

  UserModel clone() => UserModel.fromJson(toJson());

  factory ProductReviewsModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["userid"] =
        CommonMethods.convertToInt32(json["userid"], APITokenService.userId);
    json["productid"] = CommonMethods.convertToInt32(json["productid"]);
    json["reviewcount"] = CommonMethods.convertToInt32(json["reviewcount"]);
    json["ratingvalue"] = CommonMethods.convertToInt32(json["ratingvalue"]);

    return _$ProductReviewsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductReviewsModelToJson(this);
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

class Categorie {
  int id;
  String categoryname;

  Categorie({required this.id, required this.categoryname});
}

class SuggestionModel {
  bool isLocal = true;
  String text;
  SuggestionModel({required this.text, required this.isLocal});
}
