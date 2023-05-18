part of 'cat_image_bloc.dart';

abstract class CatImageState extends Equatable {
  const CatImageState();

  @override
  List<Object> get props => [];
}

class CatImageLoading extends CatImageState {}

class CatImageLoaded extends CatImageState {
  final CatImage image;

  const CatImageLoaded(this.image);
}

class CatImageError extends CatImageState {
  final String errorMessage;

  const CatImageError(this.errorMessage);
}
