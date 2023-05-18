import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../enities/fact_trivia.dart';
import '../repositories/fact_trivia_repository.dart';

class GetFactTrivia implements Usecase<FactTrivia, FactParams> {
  final FactTriviaRepository repository;

  GetFactTrivia(this.repository);

  @override
  Future<Either<Failure, FactTrivia>> call(FactParams params) async {
    return await repository.getFactTrivia();
  }
}

class FactParams extends Equatable {
  const FactParams();

  @override
  List<Object?> get props => [];
}
