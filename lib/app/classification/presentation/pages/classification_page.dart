import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../service_locator.dart';
import '../../classification.dart';

class ClassificationPage extends StatelessWidget {
  const ClassificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ClassificationBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Image Classification')),
        body: BlocConsumer<ClassificationBloc, ClassificationState>(
          listener: (context, state) {
            if (state is ClassificationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                ImagePickerWidget(
                  onImagePicked: (file) =>
                      BlocProvider.of<ClassificationBloc>(context)
                          .add(ClassifyImageEvent(file.path)),
                ),
                if (state is ClassificationLoading)
                  const CircularProgressIndicator(),
                if (state is ClassificationLoaded)
                  ClassificationResultWidget(
                      classifiedObject: state.classifiedObject),
              ],
            );
          },
        ),
      ),
    );
  }
}
