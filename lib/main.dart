import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/controllers.dart';
import 'helpers/di.dart' as di;
import 'helpers/app_routes.dart';
import 'utils/app_colors.dart';
import 'utils/app_constant.dart';
import 'utils/app_en_strings.dart';
import 'themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Map<String, Map<String, String>> _languages = await di.init();

  runApp(
    MyApp(
      languages: _languages,
    ),
  );
}

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

              transitionDuration: const Duration(milliseconds: 500),
            );
          });
    });
  }
}
