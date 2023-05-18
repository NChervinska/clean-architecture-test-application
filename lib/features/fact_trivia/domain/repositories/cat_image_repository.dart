import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../enities/cat_image.dart';

abstract class CatImageRepository {
  Future<Either<Failure, CatImage>> getCatImage();
}
