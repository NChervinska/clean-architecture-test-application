import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_application/core/error/exceptions.dart';
import 'package:test_application/core/error/failure.dart';
import 'package:test_application/core/network/network_info.dart';
import 'package:test_application/features/fact_trivia/data/datasources/fact_trivia_local_data_source.dart';
import 'package:test_application/features/fact_trivia/data/datasources/fact_trivia_remote_data_source.dart';
import 'package:test_application/features/fact_trivia/data/models/fact_trivia_model.dart';
import 'package:test_application/features/fact_trivia/data/repositories/fact_trivia_repository_impl.dart';
import 'package:test_application/features/fact_trivia/domain/enities/fact_trivia.dart';

import 'fact_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([
  FactTriviaRemoteDataSource,
  FactTriviaLocalDataSource,
  NetworkInfo,
])
void main() {
  late FactTriviaRepositoryImpl repository;
  late MockFactTriviaRemoteDataSource mockRemoteDataSource;
  late MockFactTriviaLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockFactTriviaLocalDataSource();
    mockRemoteDataSource = MockFactTriviaRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = FactTriviaRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('GetFactTrivia', () {
    const testFactTriviaModel = FactTriviaModel(fact: 'fact', length: 3);
    const FactTrivia testFactTrivia = testFactTriviaModel;

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.connected).thenAnswer((_) async => true);
      });
      test(
        'should return remote dara when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.getFactTrivia())
              .thenAnswer((_) async => testFactTriviaModel);

          final result = await repository.getFactTrivia();

          verify(mockRemoteDataSource.getFactTrivia());
          expect(result, const Right(testFactTrivia));
        },
      );

      test(
        'should cache dara locally when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.getFactTrivia())
              .thenAnswer((_) async => testFactTriviaModel);

          await repository.getFactTrivia();

          verify(mockRemoteDataSource.getFactTrivia());
          verify(mockLocalDataSource.cacheFactTrivia(testFactTriviaModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          when(mockRemoteDataSource.getFactTrivia())
              .thenThrow(ServerException());

          final result = await repository.getFactTrivia();

          verify(mockRemoteDataSource.getFactTrivia());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.connected).thenAnswer((_) async => false);
      });
      test(
        'should return locally cache data when the cached data is present',
        () async {
          when(mockLocalDataSource.getCacheFactTrivia())
              .thenAnswer((_) async => testFactTriviaModel);

          final result = await repository.getFactTrivia();

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCacheFactTrivia());
          expect(result, const Right(testFactTrivia));
        },
      );

      test(
        'should return lat CacheFailure cache data when there is no cached data present ',
        () async {
          when(mockLocalDataSource.getCacheFactTrivia())
              .thenThrow(CacheException());

          final result = await repository.getFactTrivia();

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCacheFactTrivia());
          expect(result, Left(CacheFailure()));
        },
      );
    });
  });
}
