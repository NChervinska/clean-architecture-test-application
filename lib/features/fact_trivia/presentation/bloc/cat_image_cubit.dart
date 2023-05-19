import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/enities/cat_image.dart';
import '../../domain/usecases/get_cat_image.dart';
import '../../utils/failure_converter.dart';

part 'cat_image_state.dart';

class CatImageCubit extends Cubit<CatImageState> {
  final GetCatImage getImageCat;

  CatImageCubit(this.getImageCat) : super(CatImageLoading());

  Future<void> getCatImage() async {
    emit(CatImageLoading());

    final either = await getImageCat(const CatParams());

    emit(either.fold(
      (failure) => CatImageError(mapFailureToMessage(failure)),
      (image) => CatImageLoaded(image),
    ));
  }
}
