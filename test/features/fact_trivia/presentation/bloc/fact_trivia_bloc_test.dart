import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_application/features/fact_trivia/domain/enities/fact_trivia.dart';
import 'package:test_application/features/fact_trivia/domain/usecases/get_fact_trivia.dart';
import 'package:test_application/features/fact_trivia/presentation/bloc/fact_trivia_bloc.dart';

import 'fact_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetFactTrivia])
void main() {
  late FactTriviaBloc bloc;
  late MockGetFactTrivia mockGetFactTrivia;

  setUp(() {
    mockGetFactTrivia = MockGetFactTrivia();
    bloc = FactTriviaBloc(mockGetFactTrivia);
  });

  group('GetTriviaForFact', () {
    const testFactTrivia = FactTrivia(fact: 'fact', length: 4);

    test('should get data from the use case', () async {
      when(mockGetFactTrivia(any))
          .thenAnswer((_) async => const Right(testFactTrivia));

      bloc.add(GetTriviaFactEvent());
      await untilCalled(mockGetFactTrivia(any));

      verify(mockGetFactTrivia(const FactParams()));
    });

    blocTest(
      'emits [Success] when Event is added',
      setUp: () {
        when(mockGetFactTrivia(any))
            .thenAnswer((_) async => const Right(testFactTrivia));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaFactEvent()),
      expect: () {
        return [
          FactTriviaLoading(),
          const FactTriviaLoaded(testFactTrivia),
        ];
      },
    );
  });
}
