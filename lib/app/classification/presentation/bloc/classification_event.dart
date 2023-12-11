abstract class ClassificationEvent {}

class SelectImageEvent extends ClassificationEvent {
  final String imagePath;

  SelectImageEvent(this.imagePath);
}
