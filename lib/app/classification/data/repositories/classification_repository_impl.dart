import '../../classification.dart';

class ImageClassificationRepositoryImpl
    implements ImageClassificationRepository {
  final TFLiteImageClassifier classifier;

  ImageClassificationRepositoryImpl(this.classifier);

  @override
  Future<ClassifiedImage> classifyImage(String imagePath) async {
    ClassifiedImageModel model = await classifier.classifyImage(imagePath);
    return model; // Since ClassifiedImageModel extends ClassifiedImage, it can be returned here directly
  }
}
