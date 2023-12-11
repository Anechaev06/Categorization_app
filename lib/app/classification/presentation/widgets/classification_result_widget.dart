import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entities/classified_image.dart';

class ClassificationResultWidget extends StatelessWidget {
  final ClassifiedImage classifiedImage;

  const ClassificationResultWidget({super.key, required this.classifiedImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.file(File(classifiedImage.imagePath)),
        Text('Label: ${classifiedImage.label}'),
        Text('Confidence: ${classifiedImage.confidence.toStringAsFixed(2)}'),
      ],
    );
  }
}
