import 'package:al_wasyeah/app/core/themes/controller/theme_controller.dart';
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

bool isDarkMode() {
  final themeController = Get.find<ThemeController>();
  return themeController.isDarkMode.value;
}
