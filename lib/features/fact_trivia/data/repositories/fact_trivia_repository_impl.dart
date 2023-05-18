import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/enities/fact_trivia.dart';
import '../../domain/repositories/fact_trivia_repository.dart';
import '../datasources/fact_trivia_local_data_source.dart';
import '../datasources/fact_trivia_remote_data_source.dart';

class FactTriviaRepositoryImpl implements FactTriviaRepository {
  final FactTriviaLocalDataSource localDataSource;
  final FactTriviaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FactTriviaRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, FactTrivia>> getFactTrivia() async {
    if (await networkInfo.connected) {
      try {
        final remoteTrivia = await remoteDataSource.getFactTrivia();
        localDataSource.cacheFactTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    }

    try {
      final localTrivia = await localDataSource.getCacheFactTrivia();
      return Right(localTrivia);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
