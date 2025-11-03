import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  static const String _languageKey = 'selected_language';

  final currentLocale = const Locale('es', 'ES').obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey);

    if (languageCode != null) {
      if (languageCode == 'es') {
        currentLocale.value = const Locale('es', 'ES');
      } else {
        currentLocale.value = const Locale('en', 'US');
      }
      Get.updateLocale(currentLocale.value);
    } else {
      // Set Spanish as default if no saved preference
      Get.updateLocale(const Locale('es', 'ES'));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);

    if (languageCode == 'es') {
      currentLocale.value = const Locale('es', 'ES');
    } else {
      currentLocale.value = const Locale('en', 'US');
    }

    Get.updateLocale(currentLocale.value);
  }

  bool get isEnglish => currentLocale.value.languageCode == 'en';
  bool get isSpanish => currentLocale.value.languageCode == 'es';
}
