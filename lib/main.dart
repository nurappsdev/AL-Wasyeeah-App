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
    MyApp(initialLang: savedLang),
  );
}

class MyApp extends StatefulWidget {
  final String initialLang;
  const MyApp({super.key, required this.initialLang});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
