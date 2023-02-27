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

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..TotalRow = json['TotalRow']
  ..RowIndex = json['RowIndex']
  ..id = json['id'] as int
  ..name = json['name'] as String
  ..phone = json['phone'] as String
  ..email = json['email'] as String?
  ..address = json['address'] as String?
  ..fileid = json['fileid'] as int;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'fileid': instance.fileid,
    };

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel()
      ..TotalRow = json['TotalRow']
      ..RowIndex = json['RowIndex']
      ..id = json['id'] as int
      ..name = json['name'] as String?
      ..phone = json['phone'] as String?
      ..email = json['email'] as String?
      ..fileid = json['fileid'] as int
      ..address = json['address'] as bool;

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'fileid': instance.fileid,
      'address': instance.address,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel()
  ..TotalRow = json['TotalRow']
  ..RowIndex = json['RowIndex']
  ..id = json['id'] as int
  ..name = json['name'] as String
  ..code = json['code'] as String
  ..promotion = json['promotion'] as int?
  ..ispercentpromotion = json['ispercentpromotion'] as bool
  ..price = json['price'] as int?
  ..amountexport = json['amountexport'] as int?
  ..amountimport = json['amountimport'] as int?
  ..fileid = json['fileid'] as int
  ..material = json['material'] as String?
  ..color = json['color'] as String?
  ..size = json['size'] as String?
  ..typeid = json['typeid'] as int
  ..note = json['note'] as String?
  ..updatedate = json['updatedate'] == null
      ? null
      : DateTime.parse(json['updatedate'] as String)
  ..createdate = json['createdate'] == null
      ? null
      : DateTime.parse(json['createdate'] as String);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'promotion': instance.promotion,
      'ispercentpromotion': instance.ispercentpromotion,
      'price': instance.price,
      'amountexport': instance.amountexport,
      'amountimport': instance.amountimport,
      'fileid': instance.fileid,
      'material': instance.material,
      'color': instance.color,
      'size': instance.size,
      'typeid': instance.typeid,
      'note': instance.note,
      'updatedate': instance.updatedate?.toIso8601String(),
      'createdate': instance.createdate?.toIso8601String(),
    };

ImportModel _$ImportModelFromJson(Map<String, dynamic> json) => ImportModel()
  ..TotalRow = json['TotalRow']
  ..RowIndex = json['RowIndex']
  ..id = json['id'] as int
  ..name = json['name'] as String
  ..promotion = json['promotion'] as int?
  ..count = json['count'] as int?
  ..total = json['total'] as int?
  ..updatedate = json['updatedate'] == null
      ? null
      : DateTime.parse(json['updatedate'] as String)
  ..createdate = json['createdate'] == null
      ? null
      : DateTime.parse(json['createdate'] as String);

Map<String, dynamic> _$ImportModelToJson(ImportModel instance) =>
    <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'name': instance.name,
      'promotion': instance.promotion,
      'count': instance.count,
      'total': instance.total,
      'updatedate': instance.updatedate?.toIso8601String(),
      'createdate': instance.createdate?.toIso8601String(),
    };

ExportModel _$ExportModelFromJson(Map<String, dynamic> json) => ExportModel()
  ..TotalRow = json['TotalRow']
  ..RowIndex = json['RowIndex']
  ..id = json['id'] as int
  ..name = json['name'] as String
  ..promotion = json['promotion'] as int?
  ..count = json['count'] as int?
  ..total = json['total'] as int?
  ..updatedate = json['updatedate'] == null
      ? null
      : DateTime.parse(json['updatedate'] as String)
  ..createdate = json['createdate'] == null
      ? null
      : DateTime.parse(json['createdate'] as String);

Map<String, dynamic> _$ExportModelToJson(ExportModel instance) =>
    <String, dynamic>{
      'TotalRow': instance.TotalRow,
      'RowIndex': instance.RowIndex,
      'id': instance.id,
      'name': instance.name,
      'promotion': instance.promotion,
      'count': instance.count,
      'total': instance.total,
      'updatedate': instance.updatedate?.toIso8601String(),
      'createdate': instance.createdate?.toIso8601String(),
    };

ColorModel _$ColorModelFromJson(Map<String, dynamic> json) => ColorModel(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as int,
    );

Map<String, dynamic> _$ColorModelToJson(ColorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };

SizeModel _$SizeModelFromJson(Map<String, dynamic> json) => SizeModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SizeModelToJson(SizeModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
