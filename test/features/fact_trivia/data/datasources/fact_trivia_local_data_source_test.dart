import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_application/core/error/exceptions.dart';
import 'package:test_application/features/fact_trivia/data/datasources/fact_trivia_local_data_source.dart';
import 'package:test_application/features/fact_trivia/data/models/fact_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'fact_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late FactTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = FactTriviaLocalDataSourceImpl(mockSharedPreferences);
  });

  group('getCachedTrivia', () {
    final testFactTriviaModel = FactTriviaModel.fromJson(
      json.decode(fixture('trivia.json')),
    );
    test(
      'should return FactTrivia from SharedPreferences when there is one in the cache',
      () async {
        when(mockSharedPreferences.getString(any)).thenReturn(
          fixture('trivia.json'),
        );

        final result = await dataSource.getCacheFactTrivia();

        verify(mockSharedPreferences.getString(triviaKey));
        expect(result, testFactTriviaModel);
      },
    );

    test(
      'should throw a CacheException when there is no a cached value',
      () async {
        when(mockSharedPreferences.getString(any)).thenReturn(null);

        final call = dataSource.getCacheFactTrivia;

        expect(call, throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    const testFactTriviaModel = FactTriviaModel(fact: 'f', length: 1);

    test('should call SharedPreferences to cache the data', () {
      when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async {
        return true;
      });
      dataSource.cacheFactTrivia(testFactTriviaModel);

      final expectedJsonString = json.encode(testFactTriviaModel.toJson());
      verify(mockSharedPreferences.setString(triviaKey, expectedJsonString));
    });
  });
}
