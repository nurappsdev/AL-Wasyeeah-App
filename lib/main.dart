
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/controllers.dart';
import 'helpers/di.dart' as di;
import 'helpers/app_routes.dart';
import 'themes/theme.dart';
import 'utils/utils.dart';
import 'view/screen/screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Stripe.publishableKey = AppConstants.publishAbleKey;
//   // DependencyInjection di = DependencyInjection();
//   // di.dependencies();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   runApp(const MyApp());
//
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       builder: (context, child) {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           translations: Languages(), // Use your Languages class here
//           locale: Locale('bn', 'US'), // Default locale
//           fallbackLocale: Locale('en', 'US'),
//           title: 'Service App',
//           home: const SplashScreen(),
//           getPages: AppRoutes.routes,
//           theme: light(),
//           themeMode: ThemeMode.light,
//         );
//       },
//       designSize: const Size(393, 852),
//     );
//   }
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Map<String, Map<String, String>> _languages = await di.init();


  runApp(MyApp(
    languages: _languages,
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(360, 690),
//       // minTextAdapt: true,
//       // splitScreenMode: true,
//       builder: (_, child) {
//         return GetMaterialApp(
//           translations: Languages(), // Use your Languages class here
//           locale: Locale('en', 'US'), // Default locale
//           fallbackLocale: Locale('en', 'US'), // Fallback if locale not found
//           theme: light(),
//           debugShowCheckedModeBanner: false,
//           getPages: RoutePages.routes,
//           initialRoute: RouteNames.splashScreen,
//           initialBinding: ControllerBindings(),
//         );
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizeController) {
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
              // theme: themeController.darkTheme ? dark(): light(),

              defaultTransition: Transition.topLevel,
              locale: localizeController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                  AppConstants.languages[0].countryCode),
              transitionDuration: const Duration(milliseconds: 500),
            );
          });
    });
  }
}