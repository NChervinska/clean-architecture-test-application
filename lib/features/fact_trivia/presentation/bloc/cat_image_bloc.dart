import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/enities/cat_image.dart';
import '../../domain/usecases/get_cat_image.dart';

part 'cat_image_event.dart';
part 'cat_image_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';

class CatImageBloc extends Bloc<CatImageEvent, CatImageState> {
  final GetCatImage getCatImage;

  CatImageBloc(this.getCatImage) : super(CatImageLoading()) {
    on<GetCatImageEvent>((event, emit) async {
      emit(CatImageLoading());

      final either = await getCatImage(const CatParams());

      emit(either.fold(
        (failure) => CatImageError(_mapFailureToMessage(failure)),
        (image) => CatImageLoaded(image),
      ));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;

      case CacheFailure:
        return cacheFailureMessage;

      default:
        return 'Unexpected error';
    }
  }
}
