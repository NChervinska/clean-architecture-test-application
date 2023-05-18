import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_application/features/fact_trivia/domain/enities/fact_trivia.dart';
import 'package:test_application/features/fact_trivia/domain/repositories/fact_trivia_repository.dart';
import 'package:test_application/features/fact_trivia/domain/usecases/get_fact_trivia.dart';

import 'get_fact_trivia_test.mocks.dart';

@GenerateMocks([FactTriviaRepository])
void main() {
  late GetFactTrivia usecase;
  late MockFactTriviaRepository mockFactTriviaRepository;

  setUp(() {
    mockFactTriviaRepository = MockFactTriviaRepository();
    usecase = GetFactTrivia(mockFactTriviaRepository);
  });

  const testFactTrivia = FactTrivia(fact: 'Test', length: 4);

  test('should get fact from the repository', () async {
    when(mockFactTriviaRepository.getFactTrivia()).thenAnswer(
      (_) async => const Right(testFactTrivia),
    );

    final result = await usecase(const FactParams());

    expect(result, const Right(testFactTrivia));
    verify(mockFactTriviaRepository.getFactTrivia());
    verifyNoMoreInteractions(mockFactTriviaRepository);
  });
}
