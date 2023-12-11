import '../../domain/entities/classified_object.dart';
import '../../domain/repositories/classification_repository.dart';
import '../datasources/tflite_data_source.dart';

class ClassificationRepositoryImpl implements ClassificationRepository {
  final TFLiteDataSource dataSource;

  ClassificationRepositoryImpl(this.dataSource);

  @override
  Future<ClassifiedObject> classifyImage(String imagePath) async {
    try {
      final output = await dataSource.classifyImage(imagePath);
      final highestProb =
          output.reduce((curr, next) => curr > next ? curr : next);
      final labelIndex = output.indexOf(highestProb);
      final label = _getLabelForIndex(labelIndex);
      final confidence = highestProb;
      return ClassifiedObject(label: label, confidence: confidence);
    } catch (e) {
      throw Exception('Error in classification repository: $e');
    }
  }

  String _getLabelForIndex(int index) {
    // Implement this method based on how you want to map index to label
    // Example: return labels[index];
    return 'Label for index $index'; // Placeholder implementation
  }
}
