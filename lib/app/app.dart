import 'package:flutter/material.dart';
import 'package:image_categorization/app/classification/pages/home_page.dart';
import 'core/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Financify",
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
