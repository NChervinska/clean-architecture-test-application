import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/repositories/base_repository.dart';
import '../../domain/enities/cat_image.dart';
import '../../domain/repositories/cat_image_repository.dart';
import '../datasources/cat_image_remote_data_source.dart';

class CatImageRepositoryImpl extends BaseRepository with CatImageRepository {
  final CatImageRemoteDataSource remoteDataSource;

  CatImageRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, CatImage>> getCatImage() async {
    return await makeErrorParsedCall(() async {
      final remoteImages = await remoteDataSource.getCatImage();

      if (remoteImages.isEmpty) throw ServerException();
      return remoteImages.first;
    });
  }
}
