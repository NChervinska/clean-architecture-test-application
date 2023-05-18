import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_application/features/fact_trivia/domain/enities/cat_image.dart';
import 'package:test_application/features/fact_trivia/domain/usecases/get_cat_image.dart';
import 'package:test_application/features/fact_trivia/presentation/bloc/cat_image_bloc.dart';

import 'cat_image_bloc_test.mocks.dart';

@GenerateMocks([GetCatImage])
void main() {
  late CatImageBloc bloc;
  late MockGetCatImage mockGetCatImage;

  setUp(() {
    mockGetCatImage = MockGetCatImage();
    bloc = CatImageBloc(mockGetCatImage);
  });

  group('GetCatImage', () {
    const testCatImage = CatImage(url: 'url', height: 15, id: 'id', width: 15);

    test('should get data from the use case', () async {
      when(mockGetCatImage(any))
          .thenAnswer((_) async => const Right(testCatImage));

      bloc.add(GetCatImageEvent());
      await untilCalled(mockGetCatImage(any));

      verify(mockGetCatImage(const CatParams()));
    });

    blocTest(
      'emits [Success] when Event is added',
      setUp: () {
        when(mockGetCatImage(any))
            .thenAnswer((_) async => const Right(testCatImage));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetCatImageEvent()),
      expect: () {
        return [
          CatImageLoading(),
          const CatImageLoaded(testCatImage),
        ];
      },
    );
  });
}
