import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/classify_image.dart';
import 'classification_event.dart';
import 'classification_state.dart';

class ClassificationBloc
    extends Bloc<ClassificationEvent, ClassificationState> {
  final ClassifyImage classifyImage;

  ClassificationBloc(this.classifyImage) : super(ClassificationInitial()) {
    on<ClassifyImageEvent>(_onClassifyImageEvent);
  }

  void _onClassifyImageEvent(
      ClassifyImageEvent event, Emitter<ClassificationState> emit) async {
    emit(ClassificationLoading());
    try {
      final classifiedObject = await classifyImage(event.imagePath);
      emit(ClassificationLoaded(classifiedObject));
    } catch (e) {
      emit(ClassificationError(e.toString()));
    }
  }
}
