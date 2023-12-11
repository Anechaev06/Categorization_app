import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class TFLiteDataSource {
  Interpreter? _interpreter;
  bool _isModelLoaded = false;

  TFLiteDataSource() {
    _loadModel('assets/model.tflite');
  }

  Future<void> _loadModel(String modelPath) async {
    if (!_isModelLoaded) {
      try {
        _interpreter = await Interpreter.fromAsset(modelPath);
        _isModelLoaded = true;
      } catch (e) {
        print('Error loading model: $e');
      }
    }
  }

  Future<List<dynamic>> classifyImage(String imagePath) async {
    if (!_isModelLoaded) {
      throw Exception('Model not loaded');
    }

    try {
      final image = await _loadAndDecodeImage(imagePath);
      final input = _preprocess(image);
      var output = List.filled(1 * 1000, 0).reshape([1, 1000]);
      _interpreter!.run(input, output);
      return output;
    } catch (e) {
      print('Error during classification: $e');
      rethrow;
    }
  }

  Future<img.Image> _loadAndDecodeImage(String imagePath) async {
    final file = File(imagePath);
    if (!await file.exists()) {
      throw Exception('Image file not found');
    }
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception('Failed to decode image');
    }
    return image;
  }

  Uint8List _preprocess(img.Image image) {
    final resizedImg = img.copyResize(image, width: 224, height: 224);
    return Uint8List.fromList(img.encodeJpg(resizedImg));
  }
}
