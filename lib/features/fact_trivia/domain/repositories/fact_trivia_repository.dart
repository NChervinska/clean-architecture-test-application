import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../enities/fact_trivia.dart';

abstract class FactTriviaRepository {
  Future<Either<Failure, FactTrivia>> getFactTrivia();
}
