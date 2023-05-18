import 'package:json_annotation/json_annotation.dart';

import '../../domain/enities/cat_image.dart';

part 'cat_image_model.g.dart';

@JsonSerializable()
class CatImageModel extends CatImage {
  const CatImageModel({
    required super.height,
    required super.id,
    required super.url,
    required super.width,
  });

  factory CatImageModel.fromJson(Map<String, dynamic> json) {
    return _$CatImageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CatImageModelToJson(this);
}
