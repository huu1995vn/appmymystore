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
  ..id = json['id'] as int
  ..type = json['type'] as String
  ..img = json['img'] as int
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

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel()
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

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
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
  ..id = json['id'] as int
  ..img = json['img'] as int
  ..cityid = json['cityid'] as int
  ..districtid = json['districtid'] as int
  ..username = json['username'] as String
  ..password = json['password'] as String
  ..identitynumber = json['identitynumber'] as String
  ..fullname = json['fullname'] as String
  ..jobtitle = json['jobtitle'] as String
  ..gender = json['gender'] as int
  ..birthdate = DateTime.parse(json['birthdate'] as String)
  ..email = json['email'] as String
  ..phone = json['phone'] as String
  ..phonenumber = json['phonenumber'] as String
  ..address = json['address'] as String
  ..note = json['note'] as String
  ..status = json['status'] as int;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
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
      'birthdate': instance.birthdate.toIso8601String(),
      'email': instance.email,
      'phone': instance.phone,
      'phonenumber': instance.phonenumber,
      'address': instance.address,
      'note': instance.note,
      'status': instance.status,
    };
