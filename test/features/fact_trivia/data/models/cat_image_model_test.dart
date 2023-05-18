import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_application/features/fact_trivia/data/models/cat_image_model.dart';
import 'package:test_application/features/fact_trivia/domain/enities/cat_image.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testCatImageModel = CatImageModel(
    height: 15,
    id: 'id',
    url: 'url',
    width: 15,
  );

  test('should be a subclass of CatImage entity', () async {
    expect(testCatImageModel, isA<CatImage>());
  });

  group('json', () {
    test('from json should return a valid model', () async {
      final jsonMap = json.decode(fixture('image.json'));

      final result = CatImageModel.fromJson(jsonMap);

      expect(result, testCatImageModel);
    });

    test('to json should return a JSON map containing the proper data',
        () async {
      final result = testCatImageModel.toJson();

      final expectedMap = {'height': 15, 'id': 'id', 'url': 'url', 'width': 15};
      expect(result, expectedMap);
    });
  });
}
