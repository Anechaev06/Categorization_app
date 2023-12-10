// presentation/widgets/classification_result_widget.dart

import 'package:flutter/material.dart';
import '../../domain/entities/classified_object.dart';

class ClassificationResultWidget extends StatelessWidget {
  final ClassifiedObject classifiedObject;

  const ClassificationResultWidget({super.key, required this.classifiedObject});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Classification Results',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Label: ${classifiedObject.label}'),
          const SizedBox(height: 4),
          Text('Confidence: ${classifiedObject.confidence.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
