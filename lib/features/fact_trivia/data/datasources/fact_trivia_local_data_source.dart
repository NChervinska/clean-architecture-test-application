import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/fact_trivia_model.dart';

abstract class FactTriviaLocalDataSource {
  Future<FactTriviaModel> getCacheFactTrivia();
  Future<void> cacheFactTrivia(FactTriviaModel factTrivia);
}

const triviaKey = 'trivia_key';

class FactTriviaLocalDataSourceImpl implements FactTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  FactTriviaLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<FactTriviaModel> getCacheFactTrivia() {
    final jsonString = sharedPreferences.getString(triviaKey);
    if (jsonString == null) throw CacheException();

    return Future.value(FactTriviaModel.fromJson(json.decode(jsonString)));
  }

  @override
  Future<void> cacheFactTrivia(FactTriviaModel factTrivia) {
    return sharedPreferences.setString(
      triviaKey,
      json.encode(factTrivia.toJson()),
    );
  }
}
