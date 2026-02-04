import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      // theme: themeController.darkTheme ? dark(): light(),
    );
    ;
  }
}
