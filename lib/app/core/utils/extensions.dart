import 'package:al_wasyeah/app/core/themes/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension NumberLocalization on Object? {
  dynamic toLocal() {
    if (this == null) return '';

    final locale = Get.locale?.languageCode ?? 'en';

    final formatted = NumberFormat.decimalPattern(locale).format(this);

    return formatted;
  }
}

bool isDarkMode([BuildContext? context]) {
  if (context != null) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  if (Get.isRegistered<ThemeController>()) {
    return Get.find<ThemeController>().isDarkMode.value;
  }
  return false;
}

extension ThemeContextExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  Color get cardColor => Theme.of(this).cardColor;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

