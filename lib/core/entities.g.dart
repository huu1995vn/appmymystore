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
  ..TotalRow = json['TotalRow'] as String
  ..RowIndex = json['RowIndex'] as String
  ..id = json['id'] as String
  ..type = json['type'] as String
  ..img = json['img'] as String
  ..name = json['name'] as String
  ..desc = json['desc'] as String
  ..views = json['views'] as String
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

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..TotalRow = json['TotalRow'] as String
  ..RowIndex = json['RowIndex'] as String
  ..id = json['id'] as String
  ..img = json['img'] as String
  ..cityid = json['cityid'] as String
  ..districtid = json['districtid'] as String
  ..username = json['username'] as String
  ..password = json['password'] as String
  ..identitynumber = json['identitynumber'] as String
  ..fullname = json['fullname'] as String
  ..jobtitle = json['jobtitle'] as String
  ..gender = json['gender'] as String
  ..birthdate = json['birthdate'] as String
  ..email = json['email'] as String
  ..phone = json['phone'] as String
  ..phonenumber = json['phonenumber'] as String
  ..verifyphone = json['verifyphone'] as String
  ..verifyemail = json['verifyemail'] as String
  ..address = json['address'] as String
  ..note = json['note'] as String
  ..status = json['status'] as String;

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
  ..TotalRow = json['TotalRow'] as String
  ..RowIndex = json['RowIndex'] as String
  ..id = json['id'] as String
  ..userid = json['userid'] as String
  ..usercontactid = json['usercontactid'] as String
  ..brandid = json['brandid'] as String
  ..modelid = json['modelid'] as String
  ..bodytypeid = json['bodytypeid'] as String
  ..fueltypeid = json['fueltypeid'] as String
  ..madeinid = json['madeinid'] as String
  ..colorid = json['colorid'] as String
  ..cityid = json['cityid'] as String
  ..producttypeid = json['producttypeid'] as String
  ..img = json['img'] as String
  ..imglist = json['imglist'] as String
  ..productname = json['productname'] as String
  ..description = json['description'] as String
  ..price = json['price'] as String
  ..year = json['year'] as String
  ..seat = json['seat'] as String
  ..door = json['door'] as String
  ..km = json['km'] as String
  ..state = json['state'] as String
  ..views = json['views'] as String
  ..ratingvalue = json['ratingvalue'] as String
  ..reviewcount = json['reviewcount'] as String
  ..review1 = json['review1'] as String
  ..review2 = json['review2'] as String
  ..review3 = json['review3'] as String
  ..review4 = json['review4'] as String
  ..review5 = json['review5'] as String
  ..keywordsearch = json['keywordsearch'] as String
  ..status = json['status'] as String
  ..verifydate = json['verifydate'] as String
  ..createuserid = json['createuserid'] as String
  ..createdate = json['createdate'] as String
  ..updateuserid = json['updateuserid'] as String
  ..updatedate = json['updatedate'] as String;

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
      'cityid': instance.cityid,
      'producttypeid': instance.producttypeid,
      'img': instance.img,
      'imglist': instance.imglist,
      'productname': instance.productname,
      'description': instance.description,
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
      'verifydate': instance.verifydate,
      'createuserid': instance.createuserid,
      'createdate': instance.createdate,
      'updateuserid': instance.updateuserid,
      'updatedate': instance.updatedate,
    };
