import '../../../core/error/failure.dart';
import '../presentation/fact_trivia_strings.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return FactTriviaStrings.serverFailureMessage;

    case CacheFailure:
      return FactTriviaStrings.cacheFailureMessage;

    default:
      return FactTriviaStrings.unexpectedError;
  }
}
