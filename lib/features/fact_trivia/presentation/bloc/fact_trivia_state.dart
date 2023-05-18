part of 'fact_trivia_bloc.dart';

abstract class FactTriviaState extends Equatable {
  const FactTriviaState();

  @override
  List<Object> get props => [];
}

class FactTriviaLoading extends FactTriviaState {}

class FactTriviaLoaded extends FactTriviaState {
  final FactTrivia trivia;

  const FactTriviaLoaded(this.trivia);
}

class FactTriviaError extends FactTriviaState {
  final String errorMessage;

  const FactTriviaError(this.errorMessage);
}
