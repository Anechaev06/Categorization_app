import 'package:get_it/get_it.dart';
import 'classification/classification.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Bloc
  sl.registerFactory(
    () => ClassificationBloc(classifyImage: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => ClassifyImage(sl()));

  // Repository
  sl.registerLazySingleton<ImageClassificationRepository>(
    () => ImageClassificationRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<TFLiteImageClassifier>(
    () => TFLiteImageClassifier(),
  );
}
