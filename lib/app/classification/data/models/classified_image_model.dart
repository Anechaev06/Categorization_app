import '../../classification.dart';

class ClassifiedImageModel extends ClassifiedImage {
  ClassifiedImageModel({
    required String imagePath,
    required String label,
    required double confidence,
  }) : super(imagePath: imagePath, label: label, confidence: confidence);

  // Add any additional model-specific methods here, e.g., fromJson, toJson
}
