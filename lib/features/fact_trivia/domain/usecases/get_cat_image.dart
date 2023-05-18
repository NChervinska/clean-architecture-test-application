import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../enities/cat_image.dart';
import '../repositories/cat_image_repository.dart';

class GetCatImage implements Usecase<CatImage, CatParams> {
  final CatImageRepository repository;

  GetCatImage(this.repository);

  @override
  Future<Either<Failure, CatImage>> call(CatParams params) async {
    return await repository.getCatImage();
  }
}

class CatParams extends Equatable {
  const CatParams();

  @override
  List<Object?> get props => [];
}
