import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 5) THEME CUBIT (example for using in multiple providers)
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggle() => emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
}



