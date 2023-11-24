import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      background: AppColors.backgroundColor,
    ),
    textTheme: GoogleFonts.robotoMonoTextTheme(),
  );
}
