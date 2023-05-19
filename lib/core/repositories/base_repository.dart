import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';
import '../error/failure.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> makeErrorParsedCall<T>(
    AsyncValueGetter<T> callback,
  ) async {
    try {
      return Right(await callback());
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
