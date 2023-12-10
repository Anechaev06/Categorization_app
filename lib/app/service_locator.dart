import 'package:get_it/get_it.dart';
import 'classification/classification.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<TFLiteDataSource>(() => TFLiteDataSource());

  // Register repositories
  locator.registerLazySingleton<ClassificationRepository>(
    () => ClassificationRepositoryImpl(locator()),
  );

  // Register use cases
  locator.registerLazySingleton<ClassifyImage>(
    () => ClassifyImage(locator()),
  );

  // Register BLoC
  locator.registerFactory(
    () => ClassificationBloc(locator()),
  );
}
