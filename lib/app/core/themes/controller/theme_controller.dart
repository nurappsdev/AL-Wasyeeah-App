import 'package:wasiyyat/app/core/themes/dark_theme.dart';
import 'package:wasiyyat/app/core/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final RxBool isDarkMode = false.obs;
  static const String _themeKey = 'isDarkMode';

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool(_themeKey) ?? false;
    _applyThemeMode();
  }

  void toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode.value);
    _applyThemeMode();
  }

  void _applyThemeMode() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    Get.changeTheme(isDarkMode.value ? dark : light);
  }
}
