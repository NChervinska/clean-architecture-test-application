// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatImageModel _$CatImageModelFromJson(Map<String, dynamic> json) =>
    CatImageModel(
      height: json['height'] as int,
      id: json['id'] as String,
      url: json['url'] as String,
      width: json['width'] as int,
    );

Map<String, dynamic> _$CatImageModelToJson(CatImageModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'height': instance.height,
      'width': instance.width,
      'id': instance.id,
    };
