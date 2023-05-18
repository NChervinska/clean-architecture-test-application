import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/enities/fact_trivia.dart';
import '../../domain/usecases/get_fact_trivia.dart';
import '../fact_trivia_strings.dart';

part 'fact_trivia_event.dart';
part 'fact_trivia_state.dart';

class FactTriviaBloc extends Bloc<FactTriviaEvent, FactTriviaState> {
  final GetFactTrivia getFactTrivia;

  FactTriviaBloc(this.getFactTrivia) : super(FactTriviaLoading()) {
    on<GetTriviaFactEvent>((event, emit) async {
      emit(FactTriviaLoading());

      final either = await getFactTrivia(const FactParams());

      emit(either.fold(
        (failure) => FactTriviaError(_mapFailureToMessage(failure)),
        (trivia) => FactTriviaLoaded(trivia),
      ));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return FactTriviaStrings.serverFailureMessage;

      case CacheFailure:
        return FactTriviaStrings.cacheFailureMessage;

      default:
        return FactTriviaStrings.unexpectedError;
    }
  }
}
