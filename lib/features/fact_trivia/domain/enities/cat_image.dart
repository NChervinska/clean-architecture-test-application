import 'package:equatable/equatable.dart';

class CatImage extends Equatable {
  final String url;
  final int height;
  final int width;
  final String id;

  const CatImage({
    required this.url,
    required this.height,
    required this.id,
    required this.width,
  });

  @override
  List<Object> get props => [url, height, id, width];
}
