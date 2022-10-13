// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/providers/app_provider.dart';
import 'package:raoxe/core/services/api_token.service.dart';
import 'package:raoxe/core/services/storage/storage_service.dart';
import 'package:raoxe/core/utilities/constants.dart';
import 'package:raoxe/data/ranktypes.dart';

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
  late String authorname;
  String get rxlink {
    return CommonMethods.buildUrlNews(id, prefixUrl: prefix, rewriteUrl: url);
  }

  String get rxtimeago {
    try {
      return CommonMethods.timeagoFormat(
          CommonMethods.convertToDateTime(publishdate));
    } catch (e) {
      return "NaN";
    }
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
  int status = 1;
  DateTime? createdate;
  int unread = 0;
  NotificationModel({
    required this.id,
    required this.notificationtypeid,
    required this.subject,
    required this.message,
    required this.createdate,
  });
  String get rxtimeago {
    return CommonMethods.timeagoFormat(createdate);
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["status"] = CommonMethods.convertToInt32(json["status"]);
    json["unread"] = CommonMethods.convertToInt32(json["unread"]);
    json["notificationtypeid"] =
        CommonMethods.convertToInt32(json["notificationtypeid"]);
    json["createdate"] =
        CommonMethods.convertToDateTime(json["createdate"])?.toIso8601String();
    return _$NotificationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class UserModel extends Entity {
  int id = APITokenService.userId;
  int img = -1;
  int cityid = 0;
  int districtid = 0;
  String? username;
  String? password;
  String? identitynumber;
  String? fullname = "Nguyễn Văn A";
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
    json["img"] = CommonMethods.convertToInt32(json["img"]);
    json["notificationtypeid"] =
        CommonMethods.convertToInt32(json["notificationtypeid"]);
    json["cityid"] = CommonMethods.convertToInt32(json["cityid"]);
    json["districtid"] = CommonMethods.convertToInt32(json["districtid"]);
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
  int userid = APITokenService.userId;
  int usercontactid = -1;
  int brandid = -1;
  int modelid = -1;
  int bodytypeid = -1;
  int fueltypeid = -1;
  int madeinid = -1;
  int colorid = -1;
  int producttypeid = 1;
  int img = 0;
  String? imglist;
  String? name;
  String? desc;
  int? price;
  int? year = -1;
  int? seat = -1;
  int? door = -1;
  int? km = -1;
  int state = 1;
  int views = 0;
  double ratingvalue = 0.0;
  int reviewcount = 0;
  int review1 = 0;
  int review2 = 0;
  int review3 = 0;
  int review4 = 0;
  int review5 = 0;
  String? keywordsearch;
  int status = 1;
  DateTime? verifydate;
  int? createuserid;
  DateTime? createdate;
  int? updateuserid;
  DateTime? updatedate;
  String? cityname;
  String? brandname;
  String? bodytypename;
  String? madeinname;
  String? modelname;
  String? colorname;
  String? fueltypename;
  String? fullname;
  int imguser = AppProvider.localuser.img;
  int? cityid = AppProvider.localuser.cityid;
  int? districtid = AppProvider.localuser.districtid;
  String? districtname;
  String? address = AppProvider.localuser.address;
  String? phone = AppProvider.localuser.phone;
  String? reject;
  String? username;
  bool get isfavorite {
    return StorageService.listFavorite.contains(id);
  }

  String get statename {
    return state == 1 ? "new".tr : "old".tr;
  }

  String get linkshare {
    return CommonMethods.buildDynamicLink_Product(this);
  }

  setcontact(ContactModel contact) {
    address = contact.address;
    cityid = contact.cityid;
    cityname = contact.cityname;
    districtid = contact.districtid;
    phone = contact.phone;
    fullname = contact.fullname;
    usercontactid = contact.id;
  }

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
    json["districtid"] = CommonMethods.convertToInt32(json["districtid"]);
    json["producttypeid"] =
        CommonMethods.convertToInt32(json["producttypeid"], 1);
    json["img"] = CommonMethods.convertToInt32(json["img"]);
    json["price"] = CommonMethods.convertToInt32(json["price"]);
    json["year"] = CommonMethods.convertToInt32(json["year"]);
    json["seat"] = CommonMethods.convertToInt32(json["seat"]);
    json["door"] = CommonMethods.convertToInt32(json["door"]);
    json["km"] = CommonMethods.convertToInt32(json["km"]);
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
    json["verifydate"] =
        CommonMethods.convertToDateTime(json["verifydate"])?.toIso8601String();
    json["createdate"] =
        CommonMethods.convertToDateTime(json["createdate"])?.toIso8601String();
    json["updatedate"] =
        CommonMethods.convertToDateTime(json["updatedate"])?.toIso8601String();
    json["userfavoriteid"] =
        CommonMethods.convertToInt32(json["userfavoriteid"]);
    json["isfavorite"] = CommonMethods.convertToBoolean(json["isfavorite"]);

    return _$ProductModelFromJson(json);
  }
  ProductModel clone() => ProductModel.fromJson(toJson());

  ContactModel toContact() {
    ContactModel contact = ContactModel();
    contact.id = usercontactid;
    contact.fullname = fullname;
    contact.phone = phone;
    contact.address = address;
    contact.cityid = cityid ?? 0;
    contact.districtid = districtid ?? 0;
    return contact;
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
    return CommonMethods.timeagoFormat(createdate);
  }

  String get rxprice {
    try {
      return CommonMethods.formatShortCurrency(price);
    } catch (e) {
      return "Liên hệ";
    }
  }

  String get rximguser {
    if (!(imguser > 0)) {
      return NOIMAGEUSER;
    }
    try {
      return CommonMethods.buildUrlHinhDaiDien(imguser, rewriteUrl: name);
    } catch (e) {
      CommonMethods.wirtePrint(e);

      return NOIMAGEUSER;
    }
  }

  String get rximg {
    try {
      return CommonMethods.buildUrlHinhDaiDien(img, rewriteUrl: name);
    } catch (e) {
      CommonMethods.wirtePrint(e);

      return NOIMAGEUSER;
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
          "Status",
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
          desc,
          price,
          year,
          seat,
          door,
          km,
          state,
          1,
        ],
      };
  Map<String, dynamic> toUpdate() => <String, dynamic>{
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
          "Status",
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
          desc,
          price,
          year,
          seat,
          door,
          km,
          state,
          1
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
    json["status"] = CommonMethods.convertToInt32(json["status"], 1);
    json["expirationdate"] =
        CommonMethods.convertToDateTime(json["expirationdate"])
            ?.toIso8601String();
    json["reminderdate"] = CommonMethods.convertToDateTime(json["reminderdate"])
        ?.toIso8601String();
    return _$AdvertModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AdvertModelToJson(this);
}

@JsonSerializable()
class VehicleContactModel extends Entity {
  int id = 0;
  String? code;
  int userid = 0;
  int vehiclecontacttypeid = 0;
  String? userfullname;
  String? userphone;
  String? useremail;
  String? phone;
  String? email;
  String? contactname;
  String? address;
  String? vehiclename;
  String? subject;
  String? message;
  String? url;
  String? ipaddress;
  String? browsername;
  String? browserdetail;
  String? keywordsearch;
  int status = 1;
  DateTime? createdate;

  VehicleContactModel();
  factory VehicleContactModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["userid"] = CommonMethods.convertToInt32(json["userid"]);
    json["vehiclecontacttypeid"] =
        CommonMethods.convertToInt32(json["vehiclecontacttypeid"]);
    json["createdate"] =
        CommonMethods.convertToDateTime(json["createdate"])?.toIso8601String();
    json["status"] = CommonMethods.convertToInt32(json["status"]);
    return _$VehicleContactModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VehicleContactModelToJson(this);
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
  ContactModel clone() => ContactModel.fromJson(toJson());
  ContactModel();
  bool get rxisdefault {
    // ignore: unrelated_type_equality_checks
    return isdefault == "true" || isdefault == 1;
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

  Map<String, dynamic> toDataSave([id = -1]) => <String, dynamic>{
        'id': id,
        'fields': <String>[
          "UserId",
          "CityId",
          "DistrictId",
          "FullName",
          "Phone",
          "Address"
        ],
        'datas': <dynamic>[
          userid,
          cityid,
          districtid,
          fullname,
          phone,
          address,
        ],
      };
}

@JsonSerializable()
class ReviewModel extends Entity {
  int id = 0;
  int userid = APITokenService.userId;
  int productid = 0;
  String? comment;
  String? name;
  String? desc;
  String? price;
  int reviewcount = 0;
  int ratingvalue = 5;
  DateTime? createdate;
  int status = 1;
  String? reject;
  int img = 1;
  int imguser = 1;
  String username = "";
  ReviewModel();
  String get rxtimeago {
    return CommonMethods.timeagoFormat(createdate);
  }

  String get rximguser {
    if (!(imguser > 0)) {
      return NOIMAGEUSER;
    }
    try {
      return CommonMethods.buildUrlHinhDaiDien(imguser, rewriteUrl: name);
    } catch (e) {
      CommonMethods.wirtePrint(e);

      return NOIMAGEUSER;
    }
  }

  String get rximg {
    try {
      return CommonMethods.buildUrlHinhDaiDien(img, rewriteUrl: name);
    } catch (e) {
      CommonMethods.wirtePrint(e);

      return NOIMAGEUSER;
    }
  }

  UserModel clone() => UserModel.fromJson(toJson());

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["userid"] =
        CommonMethods.convertToInt32(json["userid"], APITokenService.userId);
    json["productid"] = CommonMethods.convertToInt32(json["productid"]);
    json["reviewcount"] = CommonMethods.convertToInt32(json["reviewcount"]);
    json["ratingvalue"] = CommonMethods.convertToInt32(json["ratingvalue"]);
    json["status"] = CommonMethods.convertToInt32(json["status"], 1);
    json["imguser"] = CommonMethods.convertToInt32(json["imguser"]);
    json["img"] = CommonMethods.convertToInt32(json["img"]);
    json["createdate"] =
        CommonMethods.convertToDateTime(json["createdate"])?.toIso8601String();
    return _$ReviewModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

@JsonSerializable()
class ReportModel extends Entity {
  int id = 0;
  int userid = APITokenService.userId;
  int productid = 0;
  int reporttypeid = 0;
  String? note;
  DateTime? createdate;
  int status = 1;
  String? reject;
  ReportModel();
  String get rxtimeago {
    return CommonMethods.timeagoFormat(createdate);
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    json["id"] = CommonMethods.convertToInt32(json["id"]);
    json["userid"] =
        CommonMethods.convertToInt32(json["userid"], APITokenService.userId);
    json["productid"] = CommonMethods.convertToInt32(json["productid"]);
    json["reporttypeid"] = CommonMethods.convertToInt32(json["reporttypeid"]);
    json["status"] = CommonMethods.convertToInt32(json["status"], 1);
    json["createdate"] =
        CommonMethods.convertToDateTime(json["createdate"])?.toIso8601String();
    return _$ReportModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}

@JsonSerializable()
class ConfigModel extends Entity {
  String? apiDaiLyXe;
  String? apiDaiLyXeSufix;
  String? apiDrive;
  int? version;
  ConfigModel();
  ConfigModel clone() => ConfigModel.fromJson(toJson());
  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return _$ConfigModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ConfigModelToJson(this);
}

@JsonSerializable()
class BannerModel extends Entity {
  int id = -1;
  String src = IMAGE_NOT_FOUND;
  String? link;
  String? desc;
  String? title;
  int? no;
  BannerModel();
  BannerModel clone() => BannerModel.fromJson(toJson());
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return _$BannerModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}

@JsonSerializable()
class RankTypeModel {
  String name = "";
  String validThru;
  int point = 0;
  int id = -1;
  int discount = 0;
  int promotion = 0;
  String desc = "";
  Color get color {
    var bgColor = Colors.yellow.shade50;
    switch (id) {
      case 1:
        bgColor = Colors.yellow.shade50;
        break;
      case 2:
        bgColor = Colors.brown.shade400;
        break;
      case 3:
        bgColor = Colors.grey.shade400;
        break;
      case 4:
        bgColor = Colors.yellow.shade600;
        break;
      default:
    }
    return bgColor;
  }

  RankTypeModel(this.name, this.validThru, this.desc, this.id, this.point);

  RankTypeModel clone() => RankTypeModel.fromJson(toJson());
  factory RankTypeModel.fromJson(Map<String, dynamic> json) {
    return _$RankTypeModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$RankTypeModelToJson(this);
}

@JsonSerializable()
class PointModel {
  int currentpoint = 0;
  int usedpoint = 0;
  int ranktypeid = 1;
  int totalpoint = 0;
  RankTypeModel get ranktype {
    return rRankTypes.firstWhere((element) => element.id == ranktypeid);
  }

  PointModel(
      this.currentpoint, this.usedpoint, this.ranktypeid, this.totalpoint);

  PointModel clone() => PointModel.fromJson(toJson());
  factory PointModel.fromJson(Map<String, dynamic> json) {
    return _$PointModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$PointModelToJson(this);
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

class HistoryPoint {
  final String name;
  final String id;
  final String eventName;
  final double ammountChange;
  final bool income;
  final String date;

  HistoryPoint(this.name, this.id, this.eventName, this.ammountChange,
      this.income, this.date);
}

class CardRankTypeModel {
  String name;
  bool transfer;
  String desc;
  int id;
  int point;
  Color bgColor;
  Color fontColor;
  String validThru;

  CardRankTypeModel(
    this.name,
    this.validThru,
    this.transfer,
    this.desc,
    this.id,
    this.point,
    this.bgColor,
    this.fontColor,
  );
}
