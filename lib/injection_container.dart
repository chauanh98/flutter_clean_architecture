import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/attraction/data/datasources/remote_data_source.dart';
import 'features/attraction/domain/repositories/attraction_repository.dart';
import 'features/attraction/domain/repositories/attraction_repository_impl.dart';
import 'features/attraction/domain/usecases/get_attractions.dart';
import 'features/attraction/presentation/bloc/attraction_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => AttractionBloc(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetAttractions(sl()));

  // Repository
  sl.registerLazySingleton<AttractionRepository>(
    () => AttractionRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
