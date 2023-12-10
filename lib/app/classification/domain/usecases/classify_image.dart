import '../entities/classified_object.dart';
import '../repositories/classification_repository.dart';

class ClassifyImage {
  final ClassificationRepository repository;

  ClassifyImage(this.repository);

  Future<ClassifiedObject> call(String imagePath) async {
    return await repository.classifyImage(imagePath);
  }
}
