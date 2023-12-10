import '../entities/classified_object.dart';

abstract class ClassificationRepository {
  Future<ClassifiedObject> classifyImage(String imagePath);
}
