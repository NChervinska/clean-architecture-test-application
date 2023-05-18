import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_application/features/fact_trivia/data/models/fact_trivia_model.dart';
import 'package:test_application/features/fact_trivia/domain/enities/fact_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testFactTriviaModel = FactTriviaModel(length: 1, fact: 'Test');

  test('should be a subclass of FactTrivia entity', () async {
    expect(testFactTriviaModel, isA<FactTrivia>());
  });

  group('json', () {
    test('from json should return a valid model', () async {
      final jsonMap = json.decode(fixture('trivia.json'));

      final result = FactTriviaModel.fromJson(jsonMap);

      expect(result, testFactTriviaModel);
    });

    test('to json should return a JSON map containing the proper data',
        () async {
      final result = testFactTriviaModel.toJson();

      final expectedMap = {'fact': 'Test', 'length': 1};
      expect(result, expectedMap);
    });
  });
}
