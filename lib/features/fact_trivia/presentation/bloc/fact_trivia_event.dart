part of 'fact_trivia_bloc.dart';

abstract class FactTriviaEvent extends Equatable {
  const FactTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaFactEvent extends FactTriviaEvent {}
