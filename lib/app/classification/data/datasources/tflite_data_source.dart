import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class TFLiteDataSource {
  late Interpreter _interpreter;

  Future<void> loadModel(String modelPath) async {
    _interpreter = await Interpreter.fromAsset(modelPath);
  }

  Future<List<dynamic>> classifyImage(String imagePath) async {
    // Load the image using the 'image' package for decoding
    img.Image image = img.decodeImage(File(imagePath).readAsBytesSync())!;
    var input = _preprocess(image);

    // Create an output buffer
    var output = List.generate(1 * 1000, (index) => 0)
        .reshape([1, 1000]); // Adjust based on your model's output

    // Run the interpreter
    _interpreter.run(input, output);

    return output;
  }

  Uint8List _preprocess(img.Image image) {
    // Resize and transform the image for the model input
    // Adjust the resizing and normalization as per your model's requirements
    var resizedImg = img.copyResize(image, width: 224, height: 224);

    // Convert the image to a list of bytes (Uint8List)
    var input = resizedImg.getBytes();
    return Uint8List.fromList(input);
  }
}
