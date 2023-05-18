import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/fact_trivia/data/datasources/cat_image_remote_data_source.dart';
import '../features/fact_trivia/data/datasources/fact_trivia_local_data_source.dart';
import '../features/fact_trivia/data/datasources/fact_trivia_remote_data_source.dart';
import '../features/fact_trivia/data/repositories/cat_image_repository_impl.dart';
import '../features/fact_trivia/data/repositories/fact_trivia_repository_impl.dart';
import '../features/fact_trivia/domain/repositories/cat_image_repository.dart';
import '../features/fact_trivia/domain/repositories/fact_trivia_repository.dart';
import '../features/fact_trivia/domain/usecases/get_cat_image.dart';
import '../features/fact_trivia/domain/usecases/get_fact_trivia.dart';
import '../features/fact_trivia/presentation/bloc/cat_image_bloc.dart';
import '../features/fact_trivia/presentation/bloc/fact_trivia_bloc.dart';
import 'network/network_info.dart';

final locator = GetIt.instance;

Future<void> initDependency() async {
  ///
  /// Features
  ///

  /// Bloc
  locator.registerFactory(() => FactTriviaBloc(locator.get()));
  locator.registerFactory(() => CatImageBloc(locator.get()));

  /// Use case
  locator.registerLazySingleton(() => GetFactTrivia(locator.get()));
  locator.registerLazySingleton(() => GetCatImage(locator.get()));

  /// Repository
  locator.registerLazySingleton<FactTriviaRepository>(() {
    return FactTriviaRepositoryImpl(
      localDataSource: locator.get(),
      remoteDataSource: locator.get(),
      networkInfo: locator.get(),
    );
  });
  locator.registerLazySingleton<CatImageRepository>(() {
    return CatImageRepositoryImpl(
      remoteDataSource: locator.get(),
    );
  });

  /// Data

  locator.registerLazySingleton<FactTriviaRemoteDataSource>(() {
    return FactTriviaRemoteDataSourceImpl(locator.get());
  });
  locator.registerLazySingleton<FactTriviaLocalDataSource>(() {
    return FactTriviaLocalDataSourceImpl(locator.get());
  });
  locator.registerLazySingleton<CatImageRemoteDataSource>(() {
    return CatImageRemoteDataSourceImpl(locator.get());
  });

  ///
  /// External
  ///

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => Client());
  locator.registerLazySingleton(() => InternetConnectionChecker());

  ///
  /// Core
  ///

  locator.registerSingleton<NetworkInfo>(NetworkInfoImpl(locator.get()));
}
