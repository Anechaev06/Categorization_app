import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../service_locator.dart';
import '../../classification.dart';

class ClassificationPage extends StatelessWidget {
  const ClassificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ClassificationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Image Classification'),
        ),
        body: BlocBuilder<ClassificationBloc, ClassificationState>(
          builder: (context, state) => _buildStateContent(context, state),
        ),
      ),
    );
  }

  Widget _buildStateContent(BuildContext context, ClassificationState state) {
    if (state is ClassificationInitial) {
      return _buildImagePicker(context);
    } else if (state is ClassificationLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ClassificationLoaded) {
      return ClassificationResultWidget(classifiedImage: state.classifiedImage);
    } else if (state is ClassificationError) {
      return Center(child: Text(state.message));
    } else {
      // Logging the unexpected state can be helpful for debugging
      debugPrint('Unexpected state: $state');
      return const Center(child: Text('Unexpected state encountered'));
    }
  }

  Widget _buildImagePicker(BuildContext context) {
    return Center(
      child: ImagePickerWidget(
        onImagePicked: (path) => BlocProvider.of<ClassificationBloc>(context)
            .add(SelectImageEvent(path)),
      ),
    );
  }
}
