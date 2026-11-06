import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme(String mode) {
    if (mode == 'Dark') {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }
}
