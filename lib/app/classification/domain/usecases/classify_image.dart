import '../../classification.dart';

class ClassifyImage {
  final ImageClassificationRepository repository;

  ClassifyImage(this.repository);

  Future<ClassifiedImage> execute(String imagePath) async {
    return await repository.classifyImage(imagePath);
  }
}
