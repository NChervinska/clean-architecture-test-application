import '../../domain/enities/cat_image.dart';

class CatImageModel extends CatImage {
  const CatImageModel({
    required super.height,
    required super.id,
    required super.url,
    required super.width,
  });

  factory CatImageModel.fromJson(Map<String, dynamic> json) {
    return CatImageModel(
      height: json['height'],
      id: json['id'],
      url: json['url'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'url': url,
      'height': height,
      'id': id,
    };
  }
}
