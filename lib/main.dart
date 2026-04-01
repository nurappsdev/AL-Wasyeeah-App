import 'package:al_wasyeah/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/core/utils/api_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final prefs = await SharedPreferences.getInstance();
  final String savedLang = prefs.getString('languageCode') ?? 'en';
  final bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
  ApiConstants.currentLang = savedLang;

  runApp(
    WasyeeahApp(initialLang: savedLang, initialDarkMode: isDarkMode),
  );
}
