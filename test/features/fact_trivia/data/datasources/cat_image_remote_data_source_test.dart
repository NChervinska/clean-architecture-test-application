import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_application/core/error/exceptions.dart';
import 'package:test_application/features/fact_trivia/data/datasources/cat_image_remote_data_source.dart';
import 'package:test_application/features/fact_trivia/data/datasources/remote_constants.dart';
import 'package:test_application/features/fact_trivia/data/models/cat_image_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'fact_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  late CatImageRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = CatImageRemoteDataSourceImpl(mockClient);
  });

  void setUpMockClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => Response([fixture('image.json')].toString(), 200),
    );
  }

  void setUpMockClientFailure() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => Response('Something went wrong', 404),
    );
  }

  group('getCatImage', () {
    final testCatImageModel = CatImageModel.fromJson(
      json.decode(fixture('image.json')),
    );
    test(
      '''should perform a GET request on a URL with number 
      being the endpoint and with application/json header''',
      () {
        setUpMockClientSuccess200();

        dataSource.getCatImage();

        verify(mockClient.get(
          Uri.parse(RemoteConstants.catImageUri),
          headers: RemoteConstants.headers,
        ));
      },
    );

    test('should return CatImage when the ressponse code is 200 (success)',
        () async {
      setUpMockClientSuccess200();

      final result = await dataSource.getCatImage();

      expect(result.first, testCatImageModel);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () {
        setUpMockClientFailure();

        final call = dataSource.getCatImage;

        expect(call, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
