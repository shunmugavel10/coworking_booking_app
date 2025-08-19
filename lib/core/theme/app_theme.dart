import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.surface,
        appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
        useMaterial3: true,
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary, brightness: Brightness.dark),
        useMaterial3: true,
      );
}
