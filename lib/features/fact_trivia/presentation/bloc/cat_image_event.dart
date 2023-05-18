part of 'cat_image_bloc.dart';

abstract class CatImageEvent extends Equatable {
  const CatImageEvent();

  @override
  List<Object> get props => [];
}

class GetCatImageEvent extends CatImageEvent {}
