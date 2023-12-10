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
      print('Error during classification: $e');
      rethrow;
    }
  }

  String _getLabelForIndex(int index) {
    // Implement your logic to map the index to a label here
    return "Label for index $index";
  }
}
