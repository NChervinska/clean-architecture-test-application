import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_application/core/error/exceptions.dart';
import 'package:test_application/features/fact_trivia/data/datasources/fact_trivia_remote_data_source.dart';
import 'package:test_application/features/fact_trivia/data/datasources/remote_constants.dart';
import 'package:test_application/features/fact_trivia/data/models/fact_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'fact_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  late FactTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = FactTriviaRemoteDataSourceImpl(mockClient);
  });

  void setUpMockClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => Response(fixture('trivia.json'), 200),
    );
  }

  void setUpMockClientFailure() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => Response('Something went wrong', 404),
    );
  }

  group('getFactTrivia', () {
    final testFacctTriviaModel = FactTriviaModel.fromJson(
      json.decode(fixture('trivia.json')),
    );
    test(
      '''should perform a GET request on a URL with number 
      being the endpoint and with application/json header''',
      () {
        setUpMockClientSuccess200();

        dataSource.getFactTrivia();

        verify(mockClient.get(
          Uri.parse(RemoteConstants.factTriviaUri),
          headers: RemoteConstants.headers,
        ));
      },
    );

    test('should return FactTrivia when the ressponse code is 200 (success)',
        () async {
      setUpMockClientSuccess200();

      final result = await dataSource.getFactTrivia();

      expect(result, testFacctTriviaModel);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () {
        setUpMockClientFailure();

        final call = dataSource.getFactTrivia;

        expect(call, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
