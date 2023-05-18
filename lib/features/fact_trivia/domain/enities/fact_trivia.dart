import 'package:equatable/equatable.dart';

class FactTrivia extends Equatable {
  final String fact;
  final int length;

  const FactTrivia({
    required this.fact,
    required this.length,
  });

  @override
  List<Object> get props => [fact, length];
}
