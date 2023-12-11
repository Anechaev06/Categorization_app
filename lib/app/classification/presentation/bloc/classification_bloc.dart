import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/classify_image.dart';
import 'classification_event.dart';
import 'classification_state.dart';

class ClassificationBloc
    extends Bloc<ClassificationEvent, ClassificationState> {
  final ClassifyImage classifyImage;

  ClassificationBloc({required this.classifyImage})
      : super(ClassificationInitial()) {
    on<SelectImageEvent>(_onSelectImage);
  }

  Future<void> _onSelectImage(
      SelectImageEvent event, Emitter<ClassificationState> emit) async {
    emit(ClassificationLoading());
    try {
      final result = await classifyImage.execute(event.imagePath);
      emit(ClassificationLoaded(result));
    } catch (e) {
      emit(ClassificationError(
          "Error during image classification: ${e.toString()}"));
    }
  }
}
