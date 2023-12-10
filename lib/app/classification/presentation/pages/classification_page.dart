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
        body: Column(
          children: [
            ImagePickerWidget(onImagePicked: (file) {
              BlocProvider.of<ClassificationBloc>(context)
                  .add(ClassifyImageEvent(file.path));
            }),
            BlocBuilder<ClassificationBloc, ClassificationState>(
              builder: (context, state) {
                if (state is ClassificationLoading) {
                  return const CircularProgressIndicator();
                } else if (state is ClassificationLoaded) {
                  return ClassificationResultWidget(
                      classifiedObject: state.classifiedObject);
                } else if (state is ClassificationError) {
                  return Text('Error: ${state.message}');
                }
                return Container(); // Default empty container for initial state
              },
            ),
          ],
        ),
      ),
    );
  }
}
