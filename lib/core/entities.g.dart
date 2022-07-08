// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
      data: json['data'],
      message: json['message'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
    };

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel()
  ..TotalRow = json['TotalRow']
  ..RowIndex = json['RowIndex']
  ..id = json['id'] as int
  ..type = json['type'] as int
  ..img = json['img'] as int
  ..name = json['name'] as String
  ..desc = json['desc'] as String
  ..views = json['views'] as int
  ..publishdate = json['publishdate'] as String
  ..prefix = json['prefix'] as String
  ..url = json['url'] as String
  ..webresourceid = json['webresourceid'] as String
  ..webresourcename = json['webresourcename'] as String
  ..webresourceurl = json['webresourceurl'] as String;

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'type': instance.type,
      'img': instance.img,
      'name': instance.name,
      'desc': instance.desc,
      'views': instance.views,
      'publishdate': instance.publishdate,
      'prefix': instance.prefix,
      'url': instance.url,
      'webresourceid': instance.webresourceid,
      'webresourcename': instance.webresourcename,
      'webresourceurl': instance.webresourceurl,
    };

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as int,
      notificationtypeid: json['notificationtypeid'] as int,
      subject: json['subject'] as String,
      message: json['message'] as String,
      createdate: json['createdate'] == null
          ? null
          : DateTime.parse(json['createdate'] as String),
    )
      ..TotalRow = json['TotalRow']
      ..RowIndex = json['RowIndex'];

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'notificationtypeid': instance.notificationtypeid,
      'subject': instance.subject,
      'message': instance.message,
      'createdate': instance.createdate?.toIso8601String(),
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..TotalRow = json['TotalRow']
  ..RowIndex = json['RowIndex']
  ..id = json['id'] as int
  ..img = json['img'] as int
  ..cityid = json['cityid'] as int
  ..districtid = json['districtid'] as int
  ..username = json['username'] as String?
  ..password = json['password'] as String?
  ..identitynumber = json['identitynumber'] as String?
  ..fullname = json['fullname'] as String?
  ..jobtitle = json['jobtitle'] as String?
  ..gender = json['gender'] as int
  ..birthdate = json['birthdate'] as String?
  ..email = json['email'] as String?
  ..phone = json['phone'] as String?
  ..phonenumber = json['phonenumber'] as String?
  ..verifyphone = json['verifyphone'] as bool
  ..verifyemail = json['verifyemail'] as bool
  ..address = json['address'] as String?
  ..note = json['note'] as String?
  ..status = json['status'] as int;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'img': instance.img,
      'cityid': instance.cityid,
      'districtid': instance.districtid,
      'username': instance.username,
      'password': instance.password,
      'identitynumber': instance.identitynumber,
      'fullname': instance.fullname,
      'jobtitle': instance.jobtitle,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'email': instance.email,
      'phone': instance.phone,
      'phonenumber': instance.phonenumber,
      'verifyphone': instance.verifyphone,
      'verifyemail': instance.verifyemail,
      'address': instance.address,
      'note': instance.note,
      'status': instance.status,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel()
  ..TotalRow = json['TotalRow']
  ..RowIndex = json['RowIndex']
  ..id = json['id'] as int
  ..userid = json['userid'] as int
  ..usercontactid = json['usercontactid'] as int
  ..brandid = json['brandid'] as int
  ..modelid = json['modelid'] as int
  ..bodytypeid = json['bodytypeid'] as int
  ..fueltypeid = json['fueltypeid'] as int
  ..madeinid = json['madeinid'] as int
  ..colorid = json['colorid'] as int
  ..producttypeid = json['producttypeid'] as int
  ..img = json['img'] as int
  ..imglist = json['imglist'] as String?
  ..name = json['name'] as String?
  ..des = json['des'] as String?
  ..price = json['price'] as int?
  ..year = json['year'] as int?
  ..seat = json['seat'] as int?
  ..door = json['door'] as int?
  ..km = json['km'] as int?
  ..state = json['state'] as int
  ..views = json['views'] as int
  ..ratingvalue = (json['ratingvalue'] as num).toDouble()
  ..reviewcount = json['reviewcount'] as int
  ..review1 = json['review1'] as int
  ..review2 = json['review2'] as int
  ..review3 = json['review3'] as int
  ..review4 = json['review4'] as int
  ..review5 = json['review5'] as int
  ..keywordsearch = json['keywordsearch'] as String?
  ..status = json['status'] as int
  ..verifydate = json['verifydate'] == null
      ? null
      : DateTime.parse(json['verifydate'] as String)
  ..createuserid = json['createuserid'] as int?
  ..createdate = json['createdate'] == null
      ? null
      : DateTime.parse(json['createdate'] as String)
  ..updateuserid = json['updateuserid'] as int?
  ..updatedate = json['updatedate'] == null
      ? null
      : DateTime.parse(json['updatedate'] as String)
  ..cityname = json['cityname'] as String?
  ..brandname = json['brandname'] as String?
  ..bodytypename = json['bodytypename'] as String?
  ..madeinname = json['madeinname'] as String?
  ..modelname = json['modelname'] as String?
  ..colorname = json['colorname'] as String?
  ..fueltypename = json['fueltypename'] as String?
  ..fullname = json['fullname'] as String?
  ..imguser = json['imguser'] as int
  ..cityid = json['cityid'] as int?
  ..districtid = json['districtid'] as int?
  ..districtname = json['districtname'] as String?
  ..address = json['address'] as String?
  ..phone = json['phone'] as String?
  ..userfavoriteid = json['userfavoriteid'] as int
  ..isfavorite = json['isfavorite'] as bool;

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'userid': instance.userid,
      'usercontactid': instance.usercontactid,
      'brandid': instance.brandid,
      'modelid': instance.modelid,
      'bodytypeid': instance.bodytypeid,
      'fueltypeid': instance.fueltypeid,
      'madeinid': instance.madeinid,
      'colorid': instance.colorid,
      'producttypeid': instance.producttypeid,
      'img': instance.img,
      'imglist': instance.imglist,
      'name': instance.name,
      'des': instance.des,
      'price': instance.price,
      'year': instance.year,
      'seat': instance.seat,
      'door': instance.door,
      'km': instance.km,
      'state': instance.state,
      'views': instance.views,
      'ratingvalue': instance.ratingvalue,
      'reviewcount': instance.reviewcount,
      'review1': instance.review1,
      'review2': instance.review2,
      'review3': instance.review3,
      'review4': instance.review4,
      'review5': instance.review5,
      'keywordsearch': instance.keywordsearch,
      'status': instance.status,
      'verifydate': instance.verifydate?.toIso8601String(),
      'createuserid': instance.createuserid,
      'createdate': instance.createdate?.toIso8601String(),
      'updateuserid': instance.updateuserid,
      'updatedate': instance.updatedate?.toIso8601String(),
      'cityname': instance.cityname,
      'brandname': instance.brandname,
      'bodytypename': instance.bodytypename,
      'madeinname': instance.madeinname,
      'modelname': instance.modelname,
      'colorname': instance.colorname,
      'fueltypename': instance.fueltypename,
      'fullname': instance.fullname,
      'imguser': instance.imguser,
      'cityid': instance.cityid,
      'districtid': instance.districtid,
      'districtname': instance.districtname,
      'address': instance.address,
      'phone': instance.phone,
      'userfavoriteid': instance.userfavoriteid,
      'isfavorite': instance.isfavorite,
    };

AdvertModel _$AdvertModelFromJson(Map<String, dynamic> json) => AdvertModel()
  ..TotalRow = json['TotalRow']
  ..RowIndex = json['RowIndex']
  ..id = json['id'] as int
  ..code = json['code'] as String?
  ..img = json['img'] as int
  ..userid = json['userid'] as int
  ..adverttypeid = json['adverttypeid'] as int
  ..referenceid = json['referenceid'] as int
  ..regionname = json['regionname'] as String?
  ..displayName = json['displayName'] as String?
  ..jobtitle = json['jobtitle'] as String?
  ..phone = json['phone'] as String?
  ..email = json['email'] as String?
  ..name = json['name'] as String?
  ..price = json['price'] as int
  ..discountprice = json['discountprice'] as String?
  ..saleprice = json['saleprice'] as String?
  ..discount = json['discount'] as String?
  ..expirationdate = json['expirationdate'] == null
      ? null
      : DateTime.parse(json['expirationdate'] as String)
  ..reminderdate = json['reminderdate'] == null
      ? null
      : DateTime.parse(json['reminderdate'] as String)
  ..note = json['note'] as String?
  ..status = json['status'] as int
  ..adverttypename = json['adverttypename'] as String?
  ..adminname = json['adminname'] as String?;

Map<String, dynamic> _$AdvertModelToJson(AdvertModel instance) =>
    <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'code': instance.code,
      'img': instance.img,
      'userid': instance.userid,
      'adverttypeid': instance.adverttypeid,
      'referenceid': instance.referenceid,
      'regionname': instance.regionname,
      'displayName': instance.displayName,
      'jobtitle': instance.jobtitle,
      'phone': instance.phone,
      'email': instance.email,
      'name': instance.name,
      'price': instance.price,
      'discountprice': instance.discountprice,
      'saleprice': instance.saleprice,
      'discount': instance.discount,
      'expirationdate': instance.expirationdate?.toIso8601String(),
      'reminderdate': instance.reminderdate?.toIso8601String(),
      'note': instance.note,
      'status': instance.status,
      'adverttypename': instance.adverttypename,
      'adminname': instance.adminname,
    };

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel()
  ..TotalRow = json['TotalRow']
  ..RowIndex = json['RowIndex']
  ..id = json['id'] as int
  ..userid = json['userid'] as int
  ..cityid = json['cityid'] as int
  ..cityname = json['cityname'] as String?
  ..districtid = json['districtid'] as int
  ..districtname = json['districtname'] as String?
  ..fullname = json['fullname'] as String?
  ..phone = json['phone'] as String?
  ..address = json['address'] as String?
  ..isdefault = json['isdefault'] as bool;

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'userid': instance.userid,
      'cityid': instance.cityid,
      'cityname': instance.cityname,
      'districtid': instance.districtid,
      'districtname': instance.districtname,
      'fullname': instance.fullname,
      'phone': instance.phone,
      'address': instance.address,
      'isdefault': instance.isdefault,
    };

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel()
  ..TotalRow = json['TotalRow']
  ..RowIndex = json['RowIndex']
  ..id = json['id'] as int
  ..userid = json['userid'] as int
  ..productid = json['productid'] as int
  ..comment = json['comment'] as String?
  ..name = json['name'] as String?
  ..des = json['des'] as String?
  ..price = json['price'] as String?
  ..reviewcount = json['reviewcount'] as int
  ..ratingvalue = json['ratingvalue'] as int
  ..createdate = json['createdate'] == null
      ? null
      : DateTime.parse(json['createdate'] as String);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'userid': instance.userid,
      'productid': instance.productid,
      'comment': instance.comment,
      'name': instance.name,
      'des': instance.des,
      'price': instance.price,
      'reviewcount': instance.reviewcount,
      'ratingvalue': instance.ratingvalue,
      'createdate': instance.createdate?.toIso8601String(),
    };
