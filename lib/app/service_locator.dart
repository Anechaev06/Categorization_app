// service_locator.dart

import 'package:get_it/get_it.dart';

import 'classification/classification.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services and blocs
  locator.registerLazySingleton<TFLiteDataSource>(() => TFLiteDataSource());
  locator.registerLazySingleton<ClassificationRepository>(
      () => ClassificationRepositoryImpl(locator()));
  locator.registerFactory(() => ClassificationBloc(locator()));
}
