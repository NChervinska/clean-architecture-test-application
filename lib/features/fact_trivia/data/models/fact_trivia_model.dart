import 'package:json_annotation/json_annotation.dart';

import '../../domain/enities/fact_trivia.dart';

part 'fact_trivia_model.g.dart';

@JsonSerializable()
class FactTriviaModel extends FactTrivia {
  const FactTriviaModel({
    required super.fact,
    required super.length,
  });

  factory FactTriviaModel.fromJson(Map<String, dynamic> json) {
    return _$FactTriviaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FactTriviaModelToJson(this);
}
