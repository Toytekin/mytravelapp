import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveBoardingServices {
  // Son tema tercihini kaydetme
  static Future<void> saveBoarding(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  // Son tema tercihini yükleme
  static Future<bool> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ??
        false; // Varsayılan olarak aydınlık tema seçeneği
  }
}

class BoardingCubit extends Cubit<bool> {
  BoardingCubit() : super(false);

  // Tema tercihini yükleme işlemi
  void loadThemePreference() async {
    final isDarkMode = await HiveBoardingServices.loadThemePreference();
    emit(isDarkMode);
  }

  // Tema tercihini kaydetme işlemi
  Future<void> saveThemePreference(bool isDarkMode) async {
    await HiveBoardingServices.saveBoarding(isDarkMode);
    emit(isDarkMode);
  }
}
