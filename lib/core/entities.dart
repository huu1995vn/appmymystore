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
  String get LINK {
    return CommonMethods.buildUrlNews(int.parse(id),
        prefixUrl: prefix, rewriteUrl: url);
  }

  String get TIMEAGO {
    return CommonMethods.timeagoFormat(
        CommonMethods.convertToDateTime(publishdate));
  }

  String get URLIMG {
    int fileId = 0;
    fileId = int.parse(img);
    return CommonMethods.buildUrlHinhDaiDien(fileId, rewriteUrl: url);
  }

  NewsModel();
  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}

@JsonSerializable()
class NotificationModel extends Entity {
  final String id;
  final String notificationtypeid;
  final String subject;
  final String message;
  final String createdate;
  NotificationModel({
    required this.id,
    required this.notificationtypeid,
    required this.subject,
    required this.message,
    required this.createdate,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class UserModel extends Entity {
  late String id;
  late String img;
  late String cityid;
  late String districtid;
  late String username;
  late String password;
  late String identitynumber;
  late String fullname = "";
  late String jobtitle;
  late String gender = "1";
  late String birthdate;
  late String email;
  late String phone;
  late String phonenumber;
  late String verifyphone;
  late String verifyemail;
  late String address;
  late String note;
  late String status = "1";
  UserModel() {
    username = "";
    password = "";
    email = "";
    phone = "";
  }
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  String get URLIMG {
    try {
      int fileId = 0;
      fileId = int.parse(img);
      return CommonMethods.buildUrlHinhDaiDien(fileId, rewriteUrl: fullname);
    } catch (e) {
      CommonMethods.wirtePrint(e);

      return "";
    }
  }

  bool get VERIFY {
    return VERIFYPHONE && VERIFYEMAIL;
  }

  bool get VERIFYPHONE {
    try {
      return int.parse(verifyphone) == 1;
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
    return false;
  }

  bool get VERIFYEMAIL {
    try {
      return int.parse(verifyemail) == 1;
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
    return false;
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

@JsonSerializable()
class ProductModel extends Entity {
  late String id;
  late String userid;
  late String imguser = "";
  late String username = "";
  late String usercontactid;
  late String usercontactname = "";
  late String brandid;
  late String brandname = "";
  late String modelid;
  late String modelname = "";
  late String bodytypeid;
  late String bodytypename = "";
  late String fueltypeid;
  late String fueltypename = "";
  late String madeinid;
  late String madeinname = "";
  late String colorid;
  late String colorname = "";
  late String cityid;
  late String cityname = "";
  late String producttypeid = "1";
  late String producttypename;
  late String img;
  late String imglist;
  late String name = "";
  late String description;
  late String price;
  late String year;
  late String seat;
  late String door;
  late String km;
  late String state = "1";
  late String views;
  late String ratingvalue;
  late String reviewcount;
  late String review1;
  late String review2;
  late String review3;
  late String review4;
  late String review5;
  late String keywordsearch;
  late String status = "1";
  late String verifydate;
  late String createdate;

  ProductModel();
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

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

  String get TIMEAGO {
    return CommonMethods.timeagoFormat(
        CommonMethods.convertToDateTime(verifydate));
  }

  String get NUMPRICE {
    try {
      return NumberFormat.decimalPattern().format(int.parse(price));
    } catch (e) {
      return "not.update".tr();
    }
  }

  int get STATUS {
    return int.parse(status);
  }

  String get URLIMGUSER {
    try {
      int fileId = 0;
      fileId = int.parse(imguser);
      return CommonMethods.buildUrlHinhDaiDien(fileId, rewriteUrl: name);
    } catch (e) {
      CommonMethods.wirtePrint(e);

      return "";
    }
  }

  String get URLIMG {
    try {
      int fileId = 0;
      fileId = int.parse(img);
      return CommonMethods.buildUrlHinhDaiDien(fileId, rewriteUrl: name);
    } catch (e) {
      CommonMethods.wirtePrint(e);

      return "";
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
  late String id;
  late String code;
  late String seoid;
  late String adminid;
  late String img;
  late String userid;
  late String adverttypeid;
  late String referenceid;
  late String widgetcontentid;
  late String regionname;
  late String displayName;
  late String jobtitle;
  late String phone;
  late String email;
  late String name;
  late String price;
  late String discountprice;
  late String saleprice;
  late String discount;
  late String expirationdate;
  late String reminderdate;
  late String note;
  late String status;
  late String adverttypename;
  late String adminname;
  int get STATUS {
    return int.parse(status);
  }

  String get URLIMG {
    int fileId = 0;
    fileId = int.parse(img);
    return CommonMethods.buildUrlHinhDaiDien(fileId, rewriteUrl: name);
  }

  AdvertModel();
  factory AdvertModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertModelToJson(this);
}

@JsonSerializable()
class ContactModel extends Entity {
  final String id;
  late String userid;
  final String cityid;
  final String districtid;
  final String fullname;
  final String phone;
  final String address;
  late String isdefault;  
  ContactModel({
    required this.id,
    required this.cityid,
    required this.districtid,
    required this.phone,
    required this.address,
    required this.fullname
  })
  {
    isdefault = "False";
    userid = APITokenService.userId.toString();
  }
   bool get ISDEFAULT {
    return isdefault == "true";
  }
  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
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

class TextSearchModel {
  bool isLocal = true;
  String text;
  TextSearchModel({required this.text, required this.isLocal});
}
