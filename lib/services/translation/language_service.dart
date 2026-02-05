import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LanguageService extends GetxService {
  // Observable for current locale
  final Rx<Locale> currentLocale = (Get.locale ?? const Locale('en', 'US')).obs;

  // List of supported languages
  final List<LanguageModel> languages = [
    LanguageModel(
      languageName: 'English',
      languageCode: 'en',
      countryCode: 'US',
      flag: '🇺🇸',
    ),
    LanguageModel(
      languageName: 'বাংলা',
      languageCode: 'bn',
      countryCode: 'BD',
      flag: '🇧🇩',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    Get.updateLocale(currentLocale.value);
  }

  // Change language
  void changeLanguage(String languageCode, String countryCode) {
    final locale = Locale(languageCode, countryCode);
    currentLocale.value = locale;
    Get.updateLocale(locale);
  }

  // Helpers for UI
  bool get isEnglish =>
      currentLocale.value.languageCode == 'en';

  bool get isBangla =>
      currentLocale.value.languageCode == 'bn';

  // Generic checker (FIXED)
  bool isSelected(String languageCode, String countryCode) {
    return currentLocale.value.languageCode == languageCode &&
        currentLocale.value.countryCode == countryCode;
  }
}

// Language Model
class LanguageModel {
  final String languageName;
  final String languageCode;
  final String countryCode;
  final String flag;

  LanguageModel({
    required this.languageName,
    required this.languageCode,
    required this.countryCode,
    required this.flag,
  });
}
