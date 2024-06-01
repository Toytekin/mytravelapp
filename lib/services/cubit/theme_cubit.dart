import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(true);

  temaDegistir() {
    bool yeniDeger = !state;
    debugPrint(yeniDeger.toString());
    emit(yeniDeger);
  }
}

class LanguageCubit extends Cubit<bool> {
  LanguageCubit() : super(true);

  dilDegistir() {
    bool yeniDeger = !state;
    debugPrint(yeniDeger.toString());
    emit(yeniDeger);
  }
}
