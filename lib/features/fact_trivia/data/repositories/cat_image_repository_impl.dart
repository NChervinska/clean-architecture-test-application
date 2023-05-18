import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/enities/cat_image.dart';
import '../../domain/repositories/cat_image_repository.dart';
import '../datasources/cat_image_remote_data_source.dart';

class CatImageRepositoryImpl implements CatImageRepository {
  final CatImageRemoteDataSource remoteDataSource;

  CatImageRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, CatImage>> getCatImage() async {
    try {
      final remoteTrivia = await remoteDataSource.getCatImage();

      return Right(remoteTrivia);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
