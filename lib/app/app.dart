import 'package:flutter/material.dart';
import 'classification/classification.dart';
import 'core/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Financify",
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const ClassificationPage(),
    );
  }
}
