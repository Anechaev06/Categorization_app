import '../entities/classified_image.dart';

abstract class ImageClassificationRepository {
  Future<ClassifiedImage> classifyImage(String imagePath);
}
