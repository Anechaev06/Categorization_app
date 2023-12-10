import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/classify_image.dart';
import 'classification_event.dart';
import 'classification_state.dart';

class ClassificationBloc
    extends Bloc<ClassificationEvent, ClassificationState> {
  final ClassifyImage classifyImage;

  ClassificationBloc(this.classifyImage) : super(ClassificationInitial());

  Stream<ClassificationState> mapEventToState(
      ClassificationEvent event) async* {
    if (event is ClassifyImageEvent) {
      yield* _mapClassifyImageToState(event);
    }
  }

  Stream<ClassificationState> _mapClassifyImageToState(
      ClassifyImageEvent event) async* {
    yield ClassificationLoading();
    try {
      final classifiedObject = await classifyImage(event.imagePath);
      yield ClassificationLoaded(classifiedObject);
    } catch (e) {
      yield ClassificationError(e.toString());
    }
  }
}
