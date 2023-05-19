import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_application/core/error/exceptions.dart';
import 'package:test_application/core/error/failure.dart';
import 'package:test_application/features/fact_trivia/data/datasources/cat_image_remote_data_source.dart';
import 'package:test_application/features/fact_trivia/data/models/cat_image_model.dart';
import 'package:test_application/features/fact_trivia/data/repositories/cat_image_repository_impl.dart';
import 'package:test_application/features/fact_trivia/domain/enities/cat_image.dart';

import 'cat_image_repository_impl_test.mocks.dart';

@GenerateMocks([CatImageRemoteDataSource])
void main() {
  late CatImageRepositoryImpl repository;
  late MockCatImageRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockCatImageRemoteDataSource();

    repository = CatImageRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('GetCatImage', () {
    const testCatImageModel = CatImageModel(
      height: 10,
      id: 'id',
      url: 'url',
      width: 10,
    );
    const CatImage testCatImage = testCatImageModel;

    test(
      'should return remote dara when the call to remote data source is successful',
      () async {
        when(mockRemoteDataSource.getCatImage()).thenAnswer((_) async {
          return [testCatImageModel];
        });

        final result = await repository.getCatImage();

        verify(mockRemoteDataSource.getCatImage());
        expect(result, const Right(testCatImage));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        when(mockRemoteDataSource.getCatImage()).thenThrow(ServerException());

        final result = await repository.getCatImage();

        verify(mockRemoteDataSource.getCatImage());

        expect(result, Left(ServerFailure()));
      },
    );
  });
}
