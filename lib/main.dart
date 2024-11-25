
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'helpers/app_routes.dart';
import 'themes/theme.dart';
import 'view/screen/screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = AppConstants.publishAbleKey;
  // DependencyInjection di = DependencyInjection();
  // di.dependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Service App',
          home: const SplashScreen(),
          getPages: AppRoutes.routes,
          theme: light(),
          themeMode: ThemeMode.light,
        );
      },
      designSize: const Size(393, 852),
    );
  }
}
