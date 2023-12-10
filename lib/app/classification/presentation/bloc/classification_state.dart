import '../../classification.dart';

abstract class ClassificationState {}

class ClassificationInitial extends ClassificationState {}

class ClassificationLoading extends ClassificationState {}

class ClassificationLoaded extends ClassificationState {
  final ClassifiedObject classifiedObject;

  ClassificationLoaded(this.classifiedObject);
}

class ClassificationError extends ClassificationState {
  final String message;

  ClassificationError(this.message);
}
