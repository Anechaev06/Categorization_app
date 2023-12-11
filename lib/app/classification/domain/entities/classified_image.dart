class ClassifiedImage {
  final String imagePath;
  final String label;
  final double confidence;

  ClassifiedImage({
    required this.imagePath,
    required this.label,
    required this.confidence,
  });
}
