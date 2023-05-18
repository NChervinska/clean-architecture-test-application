import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_application/features/fact_trivia/domain/enities/cat_image.dart';
import 'package:test_application/features/fact_trivia/domain/repositories/cat_image_repository.dart';
import 'package:test_application/features/fact_trivia/domain/usecases/get_cat_image.dart';

import 'get_cat_image_test.mocks.dart';

@GenerateMocks([CatImageRepository])
void main() {
  late GetCatImage usecase;
  late MockCatImageRepository mockCatImageRepository;

  setUp(() {
    mockCatImageRepository = MockCatImageRepository();
    usecase = GetCatImage(mockCatImageRepository);
  });

  const testCatImage = CatImage(url: 'url', height: 15, id: 'id', width: 16);

  test('should get image from the repository', () async {
    when(mockCatImageRepository.getCatImage()).thenAnswer(
      (_) async => const Right(testCatImage),
    );

    final result = await usecase(const CatParams());

    expect(result, const Right(testCatImage));
    verify(mockCatImageRepository.getCatImage());
    verifyNoMoreInteractions(mockCatImageRepository);
  });
}
