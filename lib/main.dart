import 'package:al_wasyeah/services/translation/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'controllers/controllers.dart';

import 'helpers/app_routes.dart';

import 'themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "App Name",
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      theme: light(),
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.firstSplashScreen,
      initialBinding: ControllerBindings(),
      // translations: AppTranslation(), // Your translations
      // locale: Get.deviceLocale ?? const Locale('en'), // default language
      // fallbackLocale: const Locale('en'), // fallback if language not found
      translations: AppTranslation(),
      locale: Get.deviceLocale ?? const Locale('en'), // Uses device locale
      fallbackLocale: Locale('en', 'US'),
    );
  }
}
