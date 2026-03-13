import 'package:al_wasyeah/view/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/controllers.dart';
import 'helpers/app_routes.dart';
import 'themes/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'services/api_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final prefs = await SharedPreferences.getInstance();
  final String savedLang = prefs.getString('languageCode') ?? 'en';
  ApiConstants.currentLang = savedLang;

  runApp(
    WasyeeahApp(initialLang: savedLang),
  );
}
