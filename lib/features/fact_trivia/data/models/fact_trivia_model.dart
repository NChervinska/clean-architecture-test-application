import '../../domain/enities/fact_trivia.dart';

class FactTriviaModel extends FactTrivia {
  const FactTriviaModel({
    required super.fact,
    required super.length,
  });

  factory FactTriviaModel.fromJson(Map<String, dynamic> json) {
    return FactTriviaModel(fact: json['fact'], length: json['length']);
  }

  Map<String, dynamic> toJson() {
    return {
      'fact': fact,
      'length': length,
    };
  }
}
