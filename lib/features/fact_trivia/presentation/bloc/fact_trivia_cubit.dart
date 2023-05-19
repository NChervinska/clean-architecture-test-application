import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/enities/fact_trivia.dart';
import '../../domain/usecases/get_fact_trivia.dart';
import '../../utils/failure_converter.dart';

part 'fact_trivia_state.dart';

class FactTriviaCubit extends Cubit<FactTriviaState> {
  final GetFactTrivia getFactTrivia;

  FactTriviaCubit(this.getFactTrivia) : super(FactTriviaLoading()) {
    getTriviaFact();
  }

  Future<void> getTriviaFact() async {
    emit(FactTriviaLoading());

    final either = await getFactTrivia(const FactParams());

    emit(either.fold(
      (failure) => FactTriviaError(mapFailureToMessage(failure)),
      (trivia) => FactTriviaLoaded(trivia),
    ));
  }
}
