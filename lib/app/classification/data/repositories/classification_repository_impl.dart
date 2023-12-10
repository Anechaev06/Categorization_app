import '../../classification.dart';

class ClassificationRepositoryImpl implements ClassificationRepository {
  final TFLiteDataSource dataSource;

  ClassificationRepositoryImpl(this.dataSource);

  @override
  Future<ClassifiedObject> classifyImage(String imagePath) async {
    await dataSource.loadModel('assets/model.tflite');
    var output = await dataSource.classifyImage(imagePath);

    // Assuming the output is a list of probabilities for each class
    // The following logic should be adjusted based on how your model's output is structured
    var highestProb = output.reduce((curr, next) => curr > next ? curr : next);
    var labelIndex = output.indexOf(highestProb);

    // The label for each index should be mapped according to your model's labels
    String label = "Label for index $labelIndex";
    double confidence = highestProb;

    return ClassifiedObject(label: label, confidence: confidence);
  }
}
