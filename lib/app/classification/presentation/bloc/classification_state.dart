import '../../classification.dart';

abstract class ClassificationState {}

class ClassificationInitial extends ClassificationState {}

class ClassificationLoading extends ClassificationState {}

class ClassificationLoaded extends ClassificationState {
  final ClassifiedImage classifiedImage;

  ClassificationLoaded(this.classifiedImage);
}

class ClassificationError extends ClassificationState {
  final String message;

  ClassificationError(this.message);
}
