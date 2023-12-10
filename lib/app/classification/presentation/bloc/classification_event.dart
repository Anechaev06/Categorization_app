abstract class ClassificationEvent {}

class ClassifyImageEvent extends ClassificationEvent {
  final String imagePath;

  ClassifyImageEvent(this.imagePath);
}
