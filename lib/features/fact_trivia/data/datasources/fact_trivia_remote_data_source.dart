import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../models/fact_trivia_model.dart';

abstract class FactTriviaRemoteDataSource {
  Future<FactTriviaModel> getFactTrivia();
}

class FactTriviaRemoteDataSourceImpl implements FactTriviaRemoteDataSource {
  final Client client;

  FactTriviaRemoteDataSourceImpl(this.client);

  @override
  Future<FactTriviaModel> getFactTrivia() async {
    final response = await client.get(
      Uri.parse('https://catfact.ninja/fact'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) throw ServerException();

    return FactTriviaModel.fromJson(json.decode(response.body));
  }
}
