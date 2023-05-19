import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/repositories/base_repository.dart';
import '../../domain/enities/fact_trivia.dart';
import '../../domain/repositories/fact_trivia_repository.dart';
import '../datasources/fact_trivia_local_data_source.dart';
import '../datasources/fact_trivia_remote_data_source.dart';

class FactTriviaRepositoryImpl extends BaseRepository
    with FactTriviaRepository {
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
    return await makeErrorParsedCall(() async {
      if (await networkInfo.connected) {
        final remoteTrivia = await remoteDataSource.getFactTrivia();
        localDataSource.cacheFactTrivia(remoteTrivia);
        return remoteTrivia;
      }
      final localTrivia = await localDataSource.getCacheFactTrivia();
      return localTrivia;
    });
  }
}
