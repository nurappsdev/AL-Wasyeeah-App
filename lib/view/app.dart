import 'package:al_wasyeah/controllers/controller_bindings.dart';
import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';
import 'package:al_wasyeah/services/api_constants.dart';
import 'package:al_wasyeah/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WasyeeahApp extends StatefulWidget {
  final String initialLang;
  const WasyeeahApp({super.key, required this.initialLang});

  static void setLocale(BuildContext context, Locale newLocale) {
    _WasyeeahAppState? state =
        context.findAncestorStateOfType<_WasyeeahAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<WasyeeahApp> createState() => _WasyeeahAppState();
}

class _WasyeeahAppState extends State<WasyeeahApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.initialLang);
  }

  void setLocale(Locale locale) async {
    setState(() {
      _locale = locale;
    });
    Get.updateLocale(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    ApiConstants.currentLang = locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: "App Name",
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          theme: light(),
          getPages: AppRoutes.routes,
          initialRoute: AppRoutes.firstSplashScreen,
          initialBinding: ControllerBindings(),
          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
          locale: _locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('bn'),
          ],
        );
      },
    );
  }
}
