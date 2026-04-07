import 'package:al_wasyeah/app/core/route/route_names.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/core/route/router.dart';
import 'package:al_wasyeah/app/core/themes/dark_theme.dart';
import 'package:al_wasyeah/app/core/utils/api_constants.dart';
import 'package:al_wasyeah/app/core/themes/light_theme.dart';
import 'package:al_wasyeah/app/core/themes/controller/theme_controller.dart';
import 'package:al_wasyeah/app/core/widgets/app_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WasyeeahApp extends StatefulWidget {
  final String initialLang;
  final bool initialDarkMode;
  const WasyeeahApp(
      {super.key, required this.initialLang, required this.initialDarkMode});

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
  late final ThemeController _themeController;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.initialLang);
    _themeController = Get.put(ThemeController());
    _themeController.isDarkMode.value = widget.initialDarkMode;
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
          theme: light,
          darkTheme: dark,
          themeMode: widget.initialDarkMode ? ThemeMode.dark : ThemeMode.light,
          getPages: AppRouter.routes,
          initialRoute: RouteName.splashPage,
          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
          locale: _locale,
          builder: (context, child) {
            return AppWrapper(child: child ?? const SizedBox.shrink());
          },
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
